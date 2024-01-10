//
//  SceneDelegate.swift
//  HomeWork32
//
//  Created by MALYSHEW ANDREW on 9.01.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // MARK: - WINDOW:

        let window = UIWindow(windowScene: windowScene)

        // MARK: - TAB BAR ITEMS:

        let mainViewController = MainViewController()
        mainViewController.title = NSLocalizedString("Main tab bar", comment: "")
        mainViewController.tabBarItem.image = UIImage(systemName: "car.2")

        let secondViewController = AddCarViewContoller()
        secondViewController.title = NSLocalizedString("Statistic tab bar", comment: "")
        secondViewController.tabBarItem.image = UIImage(systemName: "list.bullet.clipboard.fill")

        // MARK: - NAVIGATION BAR ITEMS:

        let mainNavigationController = UINavigationController(rootViewController: mainViewController)

        // MARK: - ROOT:

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([mainNavigationController], animated: true)

        // MARK: - TAB BAR UI CONFIGURATE:

        tabBarController.tabBar.unselectedItemTintColor = .systemBrown
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.backgroundColor = .systemGray
        tabBarController.tabBar.layer.cornerRadius = 10
        tabBarController.tabBar.selectedItem?.badgeColor = .white

        // MARK: - HELPERS:

        self.window = window
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
