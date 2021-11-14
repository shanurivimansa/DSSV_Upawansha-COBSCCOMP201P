//
//  BookingVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-11-10.
//

import UIKit
import FirebaseStorage
import Firebase
import CoreLocation

class BookingVC: UIViewController,LoadingIndicatorDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var scanQrBtn: UIButton!
    @IBOutlet weak var slotNoTxt: UITextField!
    @IBOutlet weak var bookBtn: UIButton!
    
    var vm = BookingVM()
    let locationManager = CLLocationManager()
    var longitude:CLLocationDegrees?
    var latitude:CLLocationDegrees?
    var ref: DatabaseReference! = Database.database().reference()
    
    print("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slotNoTxt.text = "1"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isLocationAccessEnabled()
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
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.longitude = locValue.longitude
        self.latitude = locValue.latitude
    }
    
    
    
}


extension BookingVC:scannerDelegate{
    
    func didScannedSlotQR(slotNo: String) {
        slotNoTxt.text = slotNo
    }
    
    
}


//Location Access
extension BookingVC{
    
    func isLocationAccessEnabled() {
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                initLocationManager()
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            }
        } else {
            print("Location services not enabled")
            initLocationManager()
        }
    }
    
    
    
    func initLocationManager(){
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
            case .restricted, .denied:
                AlertProvider(vc: self).showAlertWithAction(title: "Access Needed", message: "Need permission to use the location services. Go to settings and unable access permission for location services", action: AlertAction(title: "Settings")) { (action) in
                    if action.title == "Settings" {
                        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
                        UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
                    }
                }
                break
            case .authorizedAlways, .authorizedWhenInUse:
                
                break
            default :
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}
