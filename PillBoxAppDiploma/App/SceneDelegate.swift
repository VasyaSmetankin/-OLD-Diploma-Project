//
//  SceneDelegate.swift
//  PillBoxAppDiploma
//
//  Created by Vasya Smetankin on 01.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        guard scene is UIWindowScene else { return }

        let isFirstLaunch = !UserDefaults.standard.bool(forKey: "HasLaunchedBefore")
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.makeKeyAndVisible()
        
        if !UserDefaults.standard.bool(forKey: "HasLaunchedBefore") {
            let vc = storyBoard.instantiateViewController(withIdentifier: "StartViewController")
            self.window?.rootViewController = vc
            UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
        } else {
            let vc = storyBoard.instantiateViewController(withIdentifier: "NavigationViewController")
            self.window?.rootViewController = vc
            UserDefaults.standard.set(false, forKey: "HasLaunchedBefore")
            
        }
        
            

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {

        switch shortcutItem.type {
        case "com.PillBoxAppDiploma.app.addremidner":
            print ("it just works")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "NavigationViewController")
            self.window?.rootViewController = vc
            let navcon = self.window?.rootViewController as? UINavigationController
            guard let myTabBar = navcon?.topViewController as? UITabBarController else { return }
            myTabBar.performSegue(withIdentifier: "reminderCreation", sender: nil)
            myTabBar.selectedIndex = 0
            self.window?.makeKeyAndVisible()
            completionHandler(true)
        case "com.PillBoxAppDiploma.app.addpillboxentity":
            print ("works too")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "NavigationViewController")
            self.window?.rootViewController = vc
            let navcon = self.window?.rootViewController as? UINavigationController
            guard let myTabBar = navcon?.topViewController as? UITabBarController else { return }
            myTabBar.performSegue(withIdentifier: "pillBoxCreation", sender: nil)
            myTabBar.selectedIndex = 1
            self.window?.makeKeyAndVisible()
            completionHandler(true)
        default:
            return
        }
    }


}

