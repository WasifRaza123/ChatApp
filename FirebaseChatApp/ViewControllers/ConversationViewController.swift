//
//  ViewController.swift
//  FirebaseChatApp
//
//  Created by Mohd Wasif Raza on 30/09/23.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        validateAuth()
       
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
    


}

