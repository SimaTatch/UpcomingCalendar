//
//  AppDelegate.swift
//  UpcomingCalendarApp
//
//  Created by Серафима  Татченкова  on 02.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let barAppearance = UINavigationBar.appearance()
        barAppearance.isTranslucent = false
        barAppearance.clipsToBounds = false
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 23)!]
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = UIColor.white
            appearance.titleTextAttributes = titleTextAttributes

            barAppearance.standardAppearance = appearance
            barAppearance.scrollEdgeAppearance = appearance
        } else {
            barAppearance.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.defaultPrompt)
            barAppearance.shadowImage = UIImage()
            barAppearance.barTintColor = UIColor.black
            barAppearance.titleTextAttributes = titleTextAttributes
        }
//        barAppearance.tintColor = .white
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


}

