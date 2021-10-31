//
//  USER.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-10-28.
//

import Foundation



public struct User: Codable {

    public var _id: String?
    public var firebaseId: String?
    public var uuid: String?
    public var name: String?
    
    public var promorterName: String?
    public var contactPersonName: String?
    public var abn: String?
    public var website: String?
    
    public var firstName: String?
    public var fullName: String?
    public var role: String?
    public var lastName: String?
    public var email: String?
    public var mobile: String?
    public var gender: Int?
    public var address: String?
    public var dob: String?
    public var emailVerifiedAt: String?
    public var password: String?
    public var twoFactorSecret: String?
    public var twoFactorRecoveryCodes: String?
    public var rememberToken: String?
    public var createdAt: String?
    public var updatedAt: String?
    
    public var disabledAt: String?
    public var disabledByUserId: Int?
    public var emailConfirmationSentAt: String?
    public var emailConfirmedAt: String?
    public var confirmationCode: String?
    public var avatarUrl: String?
    public var avatarPath: String?
    public var avatarDisk: String?
    public var deletedAt: String?
    public var deletedByUserId: Int?
    public var timezone: String?
    public var accessToken: String?
    public var type: Int?
    
    public init(_id: String?, firebaseId: String?, uuid: String?, name: String?, promorterName: String?, contactPersonName: String?, abn: String?, website: String?, firstName: String?, fullName: String?, role: String?,lastName: String?, email: String?, mobile: String?, gender: Int?, address: String?, dob: String?, emailVerifiedAt: String?, password: String?, twoFactorSecret: String?, twoFactorRecoveryCodes: String?, rememberToken: String?, createdAt: String?, updatedAt: String?, disabledAt: String?, disabledByUserId: Int?, emailConfirmationSentAt: String?, emailConfirmedAt: String?, confirmationCode: String?, avatarUrl: String?, avatarPath: String?, avatarDisk: String?, deletedAt: String?, deletedByUserId: Int?, timezone: String?, accessToken: String?, type: Int?) {
        self._id = _id
        self.firebaseId = firebaseId
        self.uuid = uuid
        self.name = name
        self.promorterName = promorterName
        self.contactPersonName = contactPersonName
        self.abn = abn
        self.website = website
        self.firstName = firstName
        self.fullName = fullName
        self.role = role
        self.lastName = lastName
        self.email = email
        self.gender = gender
        self.address = address
        self.mobile = mobile
        self.dob = dob
        self.emailVerifiedAt = emailVerifiedAt
        self.password = password
        self.twoFactorSecret = twoFactorSecret
        self.twoFactorRecoveryCodes = twoFactorRecoveryCodes
        self.rememberToken = rememberToken
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.disabledAt = disabledAt
        self.disabledByUserId = disabledByUserId
        self.emailConfirmationSentAt = emailConfirmationSentAt
        self.emailConfirmedAt = emailConfirmedAt
        self.confirmationCode = confirmationCode
        self.avatarUrl = avatarUrl
        self.avatarPath = avatarPath
        self.avatarDisk = avatarDisk
        self.deletedAt = deletedAt
        self.deletedByUserId = deletedByUserId
        self.timezone = timezone
        self.accessToken = accessToken
        self.type = type
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case firebaseId = "firebase_id"
        case uuid
        case name
        case promorterName = "promorter_name"
        case contactPersonName = "contact_person"
        case abn
        case website
        case firstName = "first_name"
        case fullName = "full_name"
        case role
        case lastName = "last_name"
        case email
        case mobile = "mobile"
        case dob = "date_of_birth"
        case emailVerifiedAt = "email_verified_at"
        case password
        case twoFactorSecret = "two_factor_secret"
        case twoFactorRecoveryCodes = "two_factor_recovery_codes"
        case rememberToken = "remember_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case disabledAt = "disabled_at"
        case disabledByUserId = "disabled_by_user_id"
        case emailConfirmationSentAt = "email_confirmation_sent_at"
        case emailConfirmedAt = "email_confirmed_at"
        case confirmationCode = "confirmation_code"
        case avatarUrl = "avatar_url"
        case avatarPath = "avatar_path"
        case avatarDisk = "avatar_disk"
        case deletedAt = "deleted_at"
        case deletedByUserId = "deleted_by_user_id"
        case timezone
        case accessToken = "access_token"
        case type = "type"
        case gender = "gender"
        case address = "address"
    }


}
