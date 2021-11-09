//
//  ScannerVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-11-08.
//

import UIKit
import AVFoundation

class ScannerVC: UIViewController,AVCaptureMetadataOutputObjectsDelegate  {
    
    @IBOutlet weak var square: UIImageView!
    
    var previewLayer = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }catch{
             print("error")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
        
        square.layer.borderWidth = 4
        square.layer.borderColor = UIColor.brown.cgColor
        self.view.bringSubviewToFront(square)
        
        session.startRunning()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.stopRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first{
            guard let readbleObject = metadataObject as? AVMetadataMachineReadableCodeObject else{return}
            print("readableObject :: \(readbleObject.stringValue)")
            let alert = UIAlertController(title: "QR Code", message: readbleObject.stringValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.session.stopRunning()
            }))
            
            present(alert, animated: true, completion: nil)
           
        }
    }
    
}
