//
//  BookingVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-11-10.
//

import UIKit
import FirebaseStorage
import Firebase

class BookingVC: UIViewController,LoadingIndicatorDelegate {
    
    @IBOutlet weak var scanQrBtn: UIButton!
    @IBOutlet weak var slotNoTxt: UITextField!
    @IBOutlet weak var bookBtn: UIButton!
    
    var vm = BookingVM()
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slotNoTxt.text = "1"
        // Do any additional setup after loading the view.
    }
    

    
    func fetchAvailableSlots(){
        let okAction = AlertAction(title: .Ok)
        self.startLoading()
        vm.fetchSlots{ success,code,message in
            if success{
                
                
                let idAvailable = self.vm.SlotList.filter({$0.slotId == self.slotNoTxt.text})
                if let dataToIdAvailable = idAvailable.first{
                    if dataToIdAvailable.isAvailable != "true"{
                        self.stopLoading()
                        AlertProvider(vc: self).showAlert(title: "Alert", message: "Slot is Not Available !!", action: okAction)
                    }else{
                        self.ref.child("slots").child(self.slotNoTxt.text ?? "").updateChildValues(["isAvailable": "false"])
                    }
                }
            }
            
        }
    }
    
    
    @IBAction func scanQrCodes(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ScannerVC") as! ScannerVC
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func bookSlotAction(_ sender: Any) {
        
        fetchAvailableSlots()
        
    }
    
    
    
}


extension BookingVC:scannerDelegate{
    
    func didScannedSlotQR(slotNo: String) {
        slotNoTxt.text = slotNo
    }
    
    
}
