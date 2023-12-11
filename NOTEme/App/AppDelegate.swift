//
//  AppDelegate.swift
//  NOTEme
//
//  Created by Christina on 30.10.23.
//

import UIKit
import Firebase
import FirebaseDynamicLinks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }
    
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
//        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { [weak self] (dynamicLink, error) in
//            if let dynamicLink = dynamicLink, let deepUrl = dynamicLink.url {
//                self?.processDeepLink(url: deepUrl)
//            }
//        }
//        return handled
//        }
    
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


}

