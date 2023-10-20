//
//  TabBarControllerViewController.swift
//  FirebaseChatApp
//
//  Created by Mohd Wasif Raza on 19/10/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let vc1 = UINavigationController(rootViewController: ConversationViewController())
        vc1.navigationBar.topItem?.title = "Chats"
        vc1.navigationBar.prefersLargeTitles = true
        vc1.tabBarItem.title = "Chats"
        
        let vc2 = UINavigationController(rootViewController: ProfileViewController())
        vc2.navigationBar.topItem?.title = "Profile"
        vc2.navigationBar.prefersLargeTitles = true
        vc2.tabBarItem.title = "Profile"
        
        setViewControllers([vc1,vc2], animated: false)
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .link
    }

}
