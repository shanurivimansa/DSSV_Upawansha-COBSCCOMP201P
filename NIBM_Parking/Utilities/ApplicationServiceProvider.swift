//
//  ASP.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-10-28.
//

import Foundation
import UIKit

let ASP = ApplicationServiceProvider.self


class ApplicationServiceProvider{
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let shared = ApplicationServiceProvider()

    
    
    enum Storyboard: String {
        case Auth
        case Main
        case Support
        case Promoter
        case Tickets
        case SideMenu
        case TabBar
        case TabBarPromoter
        case Settings
        case Chat
        case Guest
        case TabBarGuest
    }
    

    
    //MARK: Manage User Direction
    public func manageUserDirection(from vc: UIViewController? = nil, window: UIWindow? = nil) {
        guard LocalUser.current() != nil else {
            directToPath(in: .TabBarGuest, for: .GuestTBC, from: vc, window: window)
            return
        }

        getRedirectionWithMainInterfaceType(type: ApplicationControl.appMainInterfaceType, window: window)
    }
    
    
    
    //MARK: Get ridirection with app main interface type
    func getRedirectionWithMainInterfaceType(type: MainInterfaceType, from vc: UIViewController? = nil, window: UIWindow? = nil) {
        switch type {
        case .Main:
            directToPath(in: .Main, for: .HomeNC, from: vc, window: window)
        case .SideMenuNavigations:
            directToPath(in: .SideMenu, for: .SideMenuConfigurationVC, from: vc, window: window)
        case .TabBarNavigations:
            directToPath(in: .TabBar, for: .MainTBC, from: vc, window: window)
//            directToPath(in: .TabBarPromoter, for: .PromoterTBC, from: vc, window: window)
        case .Custom:
            break
        }
    }
    
    
    
    
    //MARK: Direct to Main Root window
    public func directToPath(in sb: Storyboard, for identifier: String, from vc: UIViewController? = nil, window: UIWindow? = nil) {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let topController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        appDelegate.setAsRoot(_controller: topController)
    }
    
    
    
    
    
    
    
}
