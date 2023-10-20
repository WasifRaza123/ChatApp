//
//  SceneDelegate.swift
//  FirebaseChatApp
//
//  Created by Mohd Wasif Raza on 30/09/23.
//

import UIKit
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootViewController = TabBarController()
//        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }

  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
      guard let url = URLContexts.first?.url else {
          return
      }

      ApplicationDelegate.shared.application(
          UIApplication.shared,
          open: url,
          sourceApplication: nil,
          annotation: [UIApplication.OpenURLOptionsKey.annotation]
      )
  }


}

