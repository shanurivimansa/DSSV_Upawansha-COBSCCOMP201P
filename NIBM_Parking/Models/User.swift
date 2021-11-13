//
//  USER.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-10-28.
//

import Foundation



public struct User: Codable {

    public var userID: String?
    public var vehicleNo:String?
    public var confirmPassword:String?
    public var contactNo:String?
    public var email:String?
    public var name:String?
    public var nic:String?
    public var password:String?
    public var registerNo:String?

    
    
    public init(userID: String?, vehicleNo: String?, confirmPassword: String?, contactNo: String?, email: String?, name: String?, nic: String?, password: String?, registerNo: String?) {
        
        self.userID = userID
        self.vehicleNo = vehicleNo
        self.confirmPassword = confirmPassword
        self.contactNo = contactNo
        self.email = email
        self.name = name
        self.nic = nic
        self.password = password
        self.registerNo = registerNo

    }

    public enum CodingKeys: String, CodingKey {
        case userID = "userID"
        case vehicleNo = "vehicleNo"
        case confirmPassword = "confirmPassword"
        case contactNo = "contactNo"
        case email = "email"
        case name = "name"
        case nic = "nic"
        case password = "password"
        case registerNo = "registerNo"
    }


}
