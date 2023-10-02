//
//  ProfileViewController.swift
//  FirebaseChatApp
//
//  Created by Mohd Wasif Raza on 02/10/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    private let data = ["Log Out"]
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "profileTableCell")
        table.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setUpView()
    }
    
    func setUpView() {
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.frame
    }
    

}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileTableCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {
            [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: false)
            }
            catch {
                print("Failed to log out")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel,
        handler: nil))
        
        present(actionSheet, animated: true)
        
        
    }
    
    
}
