//
//  AppDelegate.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 01.05.2023.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: "HasLaunchedBefore")
        
        
        
        notificationCenter.requestAuthorization(options: [.alert,.sound]) { (granted, error) in
            
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                print(settings)
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
        
        notificationCenter.delegate = self
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        if shortcutItem.type == "com.PillBoxAppDiploma.app.addremidner" {
            print("works")

        } else if shortcutItem.type == "com.PillBoxAppDiploma.app.addpillboxentity" {
            
        }
        
        
        
        completionHandler(true)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
        print(#function)
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        ReminderManager.shared.handleNotificationResponse(response: response)
    }


}



