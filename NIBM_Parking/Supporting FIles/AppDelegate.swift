//
//  AppDelegate.swift
//  NIBM_Parking
//
//  Created by Shanuri Vimansa on 2021-10-19.
//

import UIKit
import FirebaseCore
import FirebaseMessaging


let appDelegate = (UIApplication.shared.delegate as? AppDelegate)


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        FirebaseApp.configure()
        
        self.navigateToRegardingView()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
//    func setAsRoot(_controller: UIViewController) {
//        if window != nil {
//            window?.rootViewController = _controller
//        }
//    }
    
    
    
    func navigateToRegardingView() {
        if let _ = LocalUser.current() {
            let mainSB = UIStoryboard.init(storyboard: .Auth)
            let navCon = mainSB.instantiateViewController(with: ForgotPasswordVC.self)
            window?.rootViewController = navCon
            window?.makeKeyAndVisible()
        } else {
            let registrationSB = UIStoryboard.init(storyboard: .Auth)
            let navCon = registrationSB.instantiateViewController(with: LoginVC.self)
            window?.rootViewController = navCon
            window?.makeKeyAndVisible()
        }
    }
    
}

