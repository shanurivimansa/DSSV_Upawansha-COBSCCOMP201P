//
//  LoginVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-10-28.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var pwdTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginUser(_ sender: Any) {
        
        let email = userNameTxt.text
        
        let _user = User(_id: "a", firebaseId: "2", uuid: "11", name: "", promorterName: "", contactPersonName: "", abn: "", website: "", firstName: "", fullName: "", role: "", lastName: "", email: "", mobile: "", gender: 1, address: "", dob: "", emailVerifiedAt: "", password: "", twoFactorSecret: "", twoFactorRecoveryCodes: "", rememberToken: "", createdAt: "", updatedAt: "", disabledAt: "", disabledByUserId: 1, emailConfirmationSentAt: "", emailConfirmedAt: "", confirmationCode: "", avatarUrl: "", avatarPath: "", avatarDisk: "", deletedAt: "", deletedByUserId: 1, timezone: "", accessToken: "", type: 1)
        LocalUser.saveLoginData(user: _user)
        
        print(LocalUser.current())
        
    }
    
}
