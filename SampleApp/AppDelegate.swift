//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Muqeem.Ahmad on 19/04/22.
//

import UIKit
import DocereeAdSdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        DocereeMobileAds.shared().start(completionHandler: nil)
//        DocereeMobileAds.setApplicationKey("9a263052-69db-423d-9523-24cb3b9d930a") // Test API Key: WhiteCoat Prod
//        DocereeMobileAds.setApplicationKey("8b1faeef-0259-4338-bff6-b51b9c5aae53") // Live API Key: WhiteCoat Prod
        DocereeMobileAds.setApplicationKey("80332546-6312-4394-a5b9-0b1029ee4789") // Test API Key: Doceree Dev
//        DocereeMobileAds.setApplicationKey("89bb8238-498e-42ed-846f-a3b0b24b79fb") // dev env test
//        DocereeMobileAds.setApplicationKey("22de535e-c6d3-442a-a816-2c4a3e6a484a") // QA env
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

