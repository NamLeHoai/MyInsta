//
//  RegisterViewController.swift
//  MyInsta
//
//  Created by Nam on 12/14/20.
//

import UIKit
import Stevia
import Firebase
import SafariServices

class RegisterViewController: UIViewController {
    
    struct Constants {
       static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameField: UITextField = {
       let field = UITextField()
        field.placeholder = "Username"
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
    
    private let emailField: UITextField = {
       let field = UITextField()
        field.placeholder = "Email"
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
    
    private let registerButton: UIButton = {
       let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    private let loginButton: UIButton = {
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
//        [usernameField,emailField,passwordField].map { (field) in field.delegate = self}
        
    }
    
    override func viewDidLayoutSubviews() {
        setupLayout()
    }
    
    func setupLayout() {
        view.sv(usernameField, emailField, passwordField, registerButton, loginButton,termsButton,privacyButton)
        view.layout(
            220,
            |-usernameField-| ~ 48,
            32,
            |-emailField-| ~ 48,
            32,
            |-passwordField-| ~ 48,
            48,
            |-registerButton-| ~ 48,
            
            |-loginButton-| ~ 48,
            
            |-termsButton-| ~ 32,
            
            |-privacyButton-| ~ 32
        )
        registerButton.addTarget(self, action: #selector(didTabRegisterButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTabLoginButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTabTermButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTabPrivacyButton), for: .touchUpInside)
    }
    
    @objc func didTabRegisterButton() {
        guard let username = usernameField.text, username.count >= 5,
              let email = emailField.text,
              let password = passwordField.text, validate(email, password) else { return }
        
        
        // dang ky
        AuthManager.shared.registerUser(username: username, email: email, password: password) { success in
            if success {
                self.dismiss(animated: true)
            } else {
                
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
    
    @objc func didTabLoginButton() {
        let vc = RegisterViewController()
        present(vc, animated: true)
    }
    
    func validate(_ email: String, _ pass: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let passRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegex)
        return emailPred.evaluate(with: email) && passPred.evaluate(with: pass)
    }

}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField{
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
            didTabRegisterButton()
        }
        return true
    }
}
