//
//  RegisterViewController.swift
//  FirebaseChatApp
//
//  Created by Mohd Wasif Raza on 01/10/23.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class RegisterViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemGray5.cgColor
        
        
        return imageView
    }()
    
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Register"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        setUpView()
    }
    
    private func setUpView() {
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        addGestureToImageView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        firstNameField.translatesAutoresizingMaskIntoConstraints = false
        lastNameField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalToConstant: view.frame.width),
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor ),
            
            firstNameField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            firstNameField.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            firstNameField.heightAnchor.constraint(equalToConstant: 52),
            firstNameField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 10),
            lastNameField.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            lastNameField.heightAnchor.constraint(equalToConstant: 52),
            lastNameField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            emailField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 10),
            emailField.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            emailField.heightAnchor.constraint(equalToConstant: 52),
            emailField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10),
            passwordField.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            passwordField.heightAnchor.constraint(equalToConstant: 52),
            passwordField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            registerButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            registerButton.heightAnchor.constraint(equalToConstant: 52),
            registerButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set the corner radius here
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    private func addGestureToImageView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
    }
    
    @objc private func didTapChangeProfilePic(){
        presentPhotoActionSheet()
        
    }
    
    @objc private func registerButtonTapped() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        spinner.show(in: view)
        DatabaseManager.shared.userExists(with: email, completion: {[weak self] exists in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
                strongSelf.spinner.dismiss()
            }
            guard !exists else {
                // user already exists
                strongSelf.alertUserLoginError(message: "User email already exists")
                
                return
            }
            
            FirebaseAuth.Auth.auth().createUser(
                withEmail: email, password: password,
                completion: { authResult , error in
                   
                    guard authResult != nil,  error == nil else {
                        print("Error creating user")
                        return
                    }
                    DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email))
                    strongSelf.navigationController?.dismiss(animated: true)
                })
        })
        
        
        
    }
    
    @objc private func alertUserLoginError(message: String = "Please enter all information to create a new account."){
        let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Register"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        }
        else if textField == lastNameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            registerButtonTapped()
        }
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(
            UIAlertAction(title: "Take Photo", style: .default,
                          handler: { [weak self] _ in
                              self?.presentCamera()
                              
                          }))
        actionSheet.addAction(
            UIAlertAction(title: "Choose Photo", style: .default,
                          handler: { [weak self] _ in
                              self?.presentPhotoPicker()
                          }))
        present(actionSheet, animated: true)
        
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        else {
            return
        }
        self.imageView.image = selectedImage
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        
    }
}
