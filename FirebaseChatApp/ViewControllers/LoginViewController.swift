//
//  LoginViewController.swift
//  FirebaseChatApp
//
//  Created by Mohd Wasif Raza on 01/10/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        setUpView()
    }
    
    private func setUpView() {
        emailField.delegate = self
        passwordField.delegate = self
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalToConstant: view.frame.width),
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor ),
            
            emailField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            emailField.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            emailField.heightAnchor.constraint(equalToConstant: 52),
            emailField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10),
            passwordField.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            passwordField.heightAnchor.constraint(equalToConstant: 52),
            passwordField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            loginButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
    }
    
    @objc private func loginButtonTapped() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty else {
            alertUserLoginError()
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password,
                                        completion: {[weak self] authResult, error in
            guard let strongSelf = self else {return}
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email: \(email)")
                return
                
            }
            
            let user = result.user
            print("Logged in user: \(user)")
            strongSelf.navigationController?.dismiss(animated: true)
        })
    }
    
    @objc private func alertUserLoginError(){
        let alert = UIAlertController(title: "Woops", message: "Please enter all information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Register"
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            loginButtonTapped()
        }
        return true
    }
}
