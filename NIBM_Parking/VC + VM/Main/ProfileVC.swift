//
//  ProfileVC.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-11-10.
//

import UIKit

class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logOutUser(_ sender: Any) {
        
        
        
        // Delete Realm current user
        guard let user = LocalUser.current() else { return }
        RealmService.shared.delete(user)
        self.sceneDelegate?.navigateToRegardingView()
        
    }
    
    
}
