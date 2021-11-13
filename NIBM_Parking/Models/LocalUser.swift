//
//  LocalUser.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-10-28.
//

import Foundation
import RealmSwift

class LocalUser: Object {

    @objc dynamic var userID: String = ""
    @objc dynamic var vehicleNo:String = ""
    @objc dynamic var confirmPassword:String = ""
    @objc dynamic var contactNo:String = ""
    @objc dynamic var email:String = ""
    @objc dynamic var name:String = ""
    @objc dynamic var nic:String = ""
    @objc dynamic var password:String = ""
    @objc dynamic var registerNo:String = ""
    
    
    
    override class func primaryKey() -> String? {
        return "userID"
    }
    
    // Get the first object of User Model
    class func current() -> LocalUser? {
        let users = try! Realm().objects(LocalUser.self)
        return users.first
    }
    
    
    class func saveLoginData(user: User?) {
        guard (LocalUser.current() == nil) else {
            RealmService.shared.remove(objectsOfInstanceType: LocalUser.self) // Remove if exists
            self.createLocalUser(user: user) // Write user then
            return
        }
        
        self.createLocalUser(user: user) // Write user
    }
    
    
    class func createLocalUser(user: User?) {
        
        let newUser = LocalUser()
        newUser.confirmPassword = user?.confirmPassword ?? "0"
        newUser.contactNo = user?.contactNo ?? ""
        newUser.email = user?.email ?? ""
        newUser.name = user?.name ?? ""
        newUser.nic = user?.nic ?? ""
        newUser.password = user?.password ?? ""
        newUser.registerNo = user?.registerNo ?? ""
        newUser.userID = user?.userID ?? ""
        newUser.vehicleNo = user?.vehicleNo ?? ""
        
        
        
        RealmService.shared.create(object: newUser)
        
    }
    
    class func UpdateProfileData(type: ProfileUpdateType, user: User?, avatar: String?) {
        
        if let currentUser = LocalUser.current() {
            switch type {
            case .Info:
                let dict: [String: Any?] = ["firstName": user?.name ?? "", "email": user?.email ?? "", "lastName": user?.name ?? ""]
                RealmService.shared.update(object: currentUser, with: dict)
                break
            
            default:
                break
            }
        }
    }
}

enum ProfileUpdateType {
    case Info, Avatar, Unknown
}
