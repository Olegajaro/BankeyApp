//
//  ViewController.swift
//  BankeyApp
//
//  Created by Олег Федоров on 04.01.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    var userName: String? {
        loginView.userNameTextField.text
    }
    
    var password: String? {
        loginView.passwordTextField.text
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

// MARK: - SetupUI
extension LoginViewController {
    private func style() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Bankey"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 32)
        titleLabel.numberOfLines = 0
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Your premium source for all things banking!"
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8 // for indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self,
                               action: #selector(signInTapped),
                               for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.font = UIFont.boldSystemFont(ofSize: 17)
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        // TitleLabel
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(
                equalTo: descriptionLabel.topAnchor, constant: -32
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: loginView.leadingAnchor
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: loginView.trailingAnchor
            )
        ])
        
        // DescriptionLabel
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(
                equalTo: loginView.topAnchor, constant: -24
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: loginView.leadingAnchor
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: loginView.trailingAnchor
            )
        ])
        
        // LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1
            ),
            view.trailingAnchor.constraint(
                equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1
            )
        ])
        
        // SignInButton
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(
                equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2
            ),
            signInButton.leadingAnchor.constraint(
                equalTo: loginView.leadingAnchor
            ),
            signInButton.trailingAnchor.constraint(
                equalTo: loginView.trailingAnchor
            )
        ])
        
        // ErrorMessageLabel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(
                equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2
            ),
            errorMessageLabel.leadingAnchor.constraint(
                equalTo: loginView.leadingAnchor
            ),
            errorMessageLabel.trailingAnchor.constraint(
                equalTo: loginView.trailingAnchor
            )
        ])
    }
}

// MARK: - Actions
extension LoginViewController {
    @objc private func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let userName = userName, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if userName.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return 
        }
        
        if userName == "Roger" && password == "qwerty" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}
