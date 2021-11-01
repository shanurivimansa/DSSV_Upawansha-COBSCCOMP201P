//
//  LoginVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-10-28.
//

import UIKit
import FirebaseStorage
import Firebase

class LoginVC: UIViewController,LoadingIndicatorDelegate {
    
    
    var ref: DatabaseReference! = Database.database().reference()

    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var pwdTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginUser(_ sender: Any) {
        
        let validation = validateFields()
        
        if validation == nil{
            loginNetworkRequest()
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
    
    
    //Mark Validate Fields
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if userNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            pwdTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the email is correct format
        let cleanedEmail = userNameTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmailAddress(email: cleanedEmail) == false{
            return "Invalid formatted email address"
        }
        
        return nil
    }
    
    
    func loginNetworkRequest(){
        
        // Create cleaned versions of the text field
        let email = userNameTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = pwdTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            print(result as Any)
            if error != nil {
                let okAction = AlertAction(title: .Ok)
                
                AlertProvider(vc: self).showAlertWithActions(title: "Error", message: error?.localizedDescription ?? "", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        
                    } else {
                        // Will dismiss alertView by default
                    }
                })
                
            }
            else {
                
                
                self.getUserDetailsByUserID(userIDTxt: result?.user.uid)
                
                let okAction = AlertAction(title: .Ok)
                
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: "Loggin Succefully", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        
//                        let mainstoryboard = UIStoryboard(name: "TabBarController", bundle: nil)
//                        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "MainTBC") as! UITabBarController
//                        self.view.window?.rootViewController = viewController
//                        self.view.window?.makeKeyAndVisible()
                        
                        self.userNameTxt.text = ""
                        self.pwdTxt.text = ""
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }
        }
    }
    //        let email = userNameTxt.text
    //
    //        let _user = User(_id: "a", firebaseId: "2", uuid: "11", name: "", promorterName: "", contactPersonName: "", abn: "", website: "", firstName: "", fullName: "", role: "", lastName: "", email: "", mobile: "", gender: 1, address: "", dob: "", emailVerifiedAt: "", password: "", twoFactorSecret: "", twoFactorRecoveryCodes: "", rememberToken: "", createdAt: "", updatedAt: "", disabledAt: "", disabledByUserId: 1, emailConfirmationSentAt: "", emailConfirmedAt: "", confirmationCode: "", avatarUrl: "", avatarPath: "", avatarDisk: "", deletedAt: "", deletedByUserId: 1, timezone: "", accessToken: "", type: 1)
    //        LocalUser.saveLoginData(user: _user)
    //        print(LocalUser.current())
    
    
    
    //MARK:Login User Network Request
    
    func getUserDetailsByUserID(userIDTxt:String?) {
        self.startLoading()
        let userID = userIDTxt ?? ""
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print(value)
            self.stopLoading()
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
}






