//
//  ForgotPasswordVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-11-01.
//

import UIKit
import Firebase


class ForgotPasswordVC: UIViewController,LoadingIndicatorDelegate {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var resetPwdBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    //Mark Validate Fields
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            
            return "Please fill in all fields."
        }
        
        // Check if the email is correct format
        let cleanedEmail = emailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmailAddress(email: cleanedEmail) == false{
            return "Invalid formatted email address"
        }
        
        return nil
    }
    
    
    
    //MARK:Reset password network request
    func resetMyPassword(){
        let email = emailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().sendPasswordReset(withEmail: email ) { (error) in
            
            if error != nil{
                let okAction = AlertAction(title: .Ok)
                
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: error?.localizedDescription ?? "", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        self.emailTxt.text = ""
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }else{
                let okAction = AlertAction(title: .Ok)
                
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: "Reset Email Sent Succefully", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        self.emailTxt.text = ""
                        
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }
        }
    }
    
    
    @IBAction func resetPasswordEmail(_ sender: Any) {
        
        let validation = validateFields()
        
        if validation == nil{
            resetMyPassword()
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
