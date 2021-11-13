//
//  ScannerVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-11-08.
//

import UIKit
import AVFoundation


protocol scannerDelegate{
    func didScannedSlotQR(slotNo:String)
}

class ScannerVC: UIViewController,AVCaptureMetadataOutputObjectsDelegate  {
    
    @IBOutlet weak var square: UIImageView!
    
    var previewLayer = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    
    var delegate:scannerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkForAuthorizationsCamera()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.stopRunning()
    }
    
    
    func checkForAuthorizationsCamera(){
        
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .denied:
            NSLog("cameraAuthorizationStatus=denied")
            alertPromptToAllowCameraAccessViaSetting()
            
            break
        case .authorized:
            NSLog("cameraAuthorizationStatus=authorized")
            
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
            
            break
        case .restricted:
            NSLog("cameraAuthorizationStatus=restricted")
            alertPromptToAllowCameraAccessViaSetting()
            break
        case .notDetermined:
            NSLog("cameraAuthorizationStatus=notDetermined")
            requestAceess()
            break
        }
        
    }
    
    
    func requestAceess(){
        let cameraMediaType = AVMediaType.video

        // Prompting user for the permission to use the camera.
        AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
            DispatchQueue.main.sync {
                if granted {
                    // do something
                } else {
                    // do something else
                }
            }
        }
    }
    
    
    
    func alertPromptToAllowCameraAccessViaSetting() {

        let alert = UIAlertController(
            title: "IMPORTANT",
            message: "Camera access required for capturing photos!",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel) { alert in
            if AVCaptureDevice.devices(for: AVMediaType.video).count > 0 {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                    DispatchQueue.main.async() {
                        self.checkForAuthorizationsCamera() } }
            }
            }
        )
        present(alert, animated: true, completion: nil)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first{
            guard let readbleObject = metadataObject as? AVMetadataMachineReadableCodeObject else{return}
            print("readableObject :: \(readbleObject.stringValue)")
            let alert = UIAlertController(title: "QR Code", message: readbleObject.stringValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
                if let val = readbleObject.stringValue{
                    self.delegate?.didScannedSlotQR(slotNo:val)
                }
                
                self.session.stopRunning()
            }))
            
            present(alert, animated: true, completion: nil)
            
        }
    }
    
}

