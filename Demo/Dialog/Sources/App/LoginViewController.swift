//
//  LoginViewController.swift
//  DialogDemo
//
//  Created by Dmitry Tikhonov on 05.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UIKit
import Dialog

class LoginViewController: UIViewController {

    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var logoutButton: UIButton!
    @IBOutlet private var endpointLabel: UILabel!
    @IBOutlet private var loginStatusLabel: UILabel!
    @IBOutlet private var loadingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingView.isHidden = true
        endpointLabel.text = "Endpoint: \(Dialog.shared.config.endpoint)"
        updateLoginStatus()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func updateLoginStatus() {
        let isLoggedIn = Dialog.shared.isLoggedIn
        loginStatusLabel.text = "Login status: \(isLoggedIn)"
        loginButton.isEnabled = !isLoggedIn
        logoutButton.isEnabled = isLoggedIn
    }

    private func handleToken(_ token: String) {
        Dialog.shared.loginWith(token: token, completion: { [weak self] _ in
            self?.loadingView.isHidden = true
            self?.updateLoginStatus()
        })
    }

    @IBAction private func login(_ sender: Any) {
        guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !username.isEmpty,
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !password.isEmpty else {
                return
        }

        loadingView.isHidden = false
        Dialog.shared.loginWith(username: username, password: password) { [weak self] result in
            switch result {
            case .success(let token):
                self?.handleToken(token)
            case .failure:
                self?.loadingView.isHidden = true
                return
            }
        }
    }

    @IBAction private func logout(_ sender: Any) {
        Dialog.shared.logout(completion: { [weak self] _ in
            self?.updateLoginStatus()
        })
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
