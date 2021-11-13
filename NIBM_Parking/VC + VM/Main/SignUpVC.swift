//
//  SignUpVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-11-01.
//

import UIKit
import Firebase

class SignUpVC: UIViewController,LoadingIndicatorDelegate {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailAddressTxt: UITextField!
    @IBOutlet weak var nicTxt: UITextField!
    @IBOutlet weak var contactNoTxt: UITextField!
    @IBOutlet weak var regNoTxt: UITextField!
    @IBOutlet weak var vehicleNoTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    var ref: DatabaseReference! = Database.database().reference()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:Validations
    func validateFields() -> String? {
        
        let cleanedName = nameTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = emailAddressTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedNIC = nicTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedContactNo = contactNoTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedRegNo = regNoTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedVehicleNo = vehicleNoTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPassword = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedConfirmPassword = confirmPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        // MARK:Check that all fields are filled in
        if cleanedName == "" || cleanedEmail == "" || cleanedNIC == "" || cleanedContactNo == "" || cleanedRegNo == "" || cleanedVehicleNo == "" || cleanedPassword == "" || cleanedConfirmPassword == ""    {
            return "Please fill in all fields."
        }
        // MARK:Check that valid email entered
        if Utilities.isValidEmailAddress(email: cleanedEmail) == false{
            return "Invalid  email address"
        }
        // MARK:Check that valid phone number entered
        if Utilities.isValidPhoneNumber(phone: cleanedContactNo) == false{
            return "Invalid phone number"
        }
        // MARK:Check that valid password entered
        if Utilities.isPasswordValid(cleanedPassword) == false{
            return "Password should contan 8 charcters with special character"
        }
        
        if cleanedPassword != cleanedConfirmPassword {
            return "Password and confirm password should match"
        }
        
        return nil
    }
    
    
    func registerUserNetworkRequest(){
        // Create cleaned versions of the data
        let cleanedName = nameTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = emailAddressTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedNIC = nicTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedContactNo = contactNoTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedRegNo = regNoTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedVehicleNo = vehicleNoTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPassword = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedConfirmPassword = confirmPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Create the user
        Auth.auth().createUser(withEmail: cleanedEmail, password: cleanedPassword) { (result, err) in
            
            // Check for errors
            if err != nil {
                let okAction = AlertAction(title: .Ok)
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: err?.localizedDescription ?? "", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        self.nameTxt.text = ""
                        self.emailAddressTxt.text = ""
                        self.nicTxt.text = ""
                        self.contactNoTxt.text = ""
                        self.regNoTxt.text = ""
                        self.passwordTxt.text = ""
                        self.confirmPassword.text = ""
                        self.vehicleNoTxt.text = ""
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }
            else {
                self.ref.child("users").child(result?.user.uid ?? "").setValue(["userID":result?.user.uid,"name":cleanedName ,"email":cleanedEmail ,"nic":cleanedNIC ,"contactNo":cleanedContactNo ,"registerNo":cleanedRegNo,"vehicleNo":cleanedVehicleNo ,"password":cleanedPassword ,"confirmPassword":cleanedConfirmPassword])
                
                let okAction = AlertAction(title: .Ok)
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: "Registered Successfully" , actions: [okAction], completion: { action in
                    
                    
                    let _user = User(userID: "", vehicleNo: "", confirmPassword: "", contactNo: "", email: "", name: "", nic: "", password: "", registerNo: "")
                    LocalUser.saveLoginData(user: _user)
                    
                    if action.title == .Ok {
                        
                        self.getUserDetailsByUserID(userIDTxt: result?.user.uid)
                        
                        
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }
        }
    }
    
    
    
    func getUserDetailsByUserID(userIDTxt:String?) {
        self.startLoading()
        let userID = userIDTxt ?? ""
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            print(username)
            self.stopLoading()
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    @IBAction func signUpUser(_ sender: Any) {
        
        let validation = validateFields()
        
        if validation == nil{
            registerUserNetworkRequest()
        }else{
            let okAction = AlertAction(title: .Ok)
            
            AlertProvider(vc: self).showAlertWithActions(title: "Error", message:validation ?? "", actions: [okAction], completion: { action in
                if action.title == .Ok {
                } else {
                    // Will dismiss alertView by default
                }
            })
        }
        
    }
    
    
    
}
