//
//  LoginViewController.swift
//  GoogleMapsTracker
//
//  Created by admin on 11.12.2022.
//

import UIKit
import GoogleMaps

class LoginViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        var isCorrectLogin = false
        for user in UserDataBase.instance.users {
            if loginTextField.text == user.login && passwordTextField.text == user.password {
                isCorrectLogin.toggle()
            }
        }
        if isCorrectLogin {
            let vc = storyboard?.instantiateViewController(withIdentifier: "mapVC")
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func registrationButtonPressed(_ sender: UIButton) {
        var isNewUser = true
        var currentUserIndex = -1
        if let login = loginTextField.text,
           let password = passwordTextField.text {
            for userIndex in UserDataBase.instance.users.indices {
                if login == UserDataBase.instance.users[userIndex].login {
                    isNewUser.toggle()
                    currentUserIndex = userIndex
                }
            }
            if !isNewUser {
                UserDataBase.instance.users[currentUserIndex].password = password
            } else {
                UserDataBase.instance.users.append(User(login: login, password: password))
            }
            for user in UserDataBase.instance.users {
                print(user.login)
                print(user.password)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
