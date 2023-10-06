//
//  ViewController.swift
//  FirebaseChatApp
//
//  Created by Mohd Wasif Raza on 30/09/23.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "conversation"
        
        let vc1 = UINavigationController(rootViewController: ChatViewController())
        vc1.navigationBar.topItem?.title = "Chats"
        vc1.tabBarItem.title = "Chats"
        
        let vc2 = UINavigationController(rootViewController: ProfileViewController())
        vc2.navigationBar.topItem?.title = "Profile"
        vc2.tabBarItem.title = "Profile"
        
        setViewControllers([vc1,vc2], animated: false)
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .link
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }
}

