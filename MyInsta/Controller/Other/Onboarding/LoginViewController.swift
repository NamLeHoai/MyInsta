//
//  LoginViewController.swift
//  MyInsta
//
//  Created by Nam on 12/14/20.
//

import UIKit
import Stevia
import Firebase
import SafariServices
class LoginViewController: UIViewController {
    
    struct Constants {
       static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameEmailField: UITextField = {
       let field = UITextField()
        field.placeholder = "Username or Email"
        field.textColor = .secondaryLabel
        field.backgroundColor = .secondarySystemBackground
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.masksToBounds = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.cornerRadius = Constants.cornerRadius
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .next
        return field
    }()
    
    private let passwordField: UITextField = {
       let field = UITextField()
        field.placeholder = "Password"
        field.textColor = .secondaryLabel
        field.backgroundColor = .secondarySystemBackground
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.masksToBounds = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.cornerRadius = Constants.cornerRadius
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    private let createAccountButton: UIButton = {
       let button = UIButton()
        button.setTitle("Don't have Account? create here", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Services", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [usernameEmailField,passwordField].map { (field) in field.delegate = self}
        usernameEmailField.text = "namdeptrai@gmail.com"
        passwordField.text = "namtien97"
    }
    
    override func viewDidLayoutSubviews() {
        setupLayout()
    }
    
    func setupLayout() {
        view.sv(usernameEmailField,passwordField,loginButton, createAccountButton,termsButton,privacyButton)
        view.layout(
            220,
            |-usernameEmailField-| ~ 48,
            32,
            |-passwordField-| ~ 48,
            48,
            |-loginButton-| ~ 48,
            32,
            |-createAccountButton-| ~ 48,
            24,
            |-termsButton-| ~ 32,
            24,
            |-privacyButton-| ~ 32
        )
        loginButton.addTarget(self, action: #selector(didTabLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTabCreateButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTabTermButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTabPrivacyButton), for: .touchUpInside)
    }
    
    @objc func didTabLoginButton() {
        //loai bo ban phim
        usernameEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        // lấy text từ textfield
        guard let userEmail = usernameEmailField.text, let password = passwordField.text, validate(userEmail, password) else {return}
        var email: String?
        var username: String?
        
        if userEmail.contains("@"), userEmail.contains(".") {
            email = userEmail
        } else {
            username = userEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            if success {
                // tro ve home
                self.dismiss(animated: true)
            } else {
                // error occured, tao alert -> set action -> hien alert
                let alert = UIAlertController(title: "Login Error", message: "We were unable to log ur in", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dissmiss", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
            }
        
        }
    }
    
    @objc func didTabTermButton() {
        guard let url = URL(string: "https://www.facebook.com/help/instagram/termsofuse") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTabPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTabCreateButton() {
        let vc = RegisterViewController()
        present(vc, animated: true)
    }
    
    func validate(_ userEmail: String?, _ pass: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let passRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegex)
        return emailPred.evaluate(with: userEmail) && passPred.evaluate(with: pass)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
            didTabLoginButton()
        }
        return true
    }
}
