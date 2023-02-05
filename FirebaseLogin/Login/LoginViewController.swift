//
//  LoginViewController.swift
//  FirebaseLogin
//
//  Created by Manuel Rodriguez Sebastian on 26/1/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    private let userDefaults = UserDefaultsManager()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.isEnabled = false
        }
    }
    
    private var isEmailEmpty: Bool = true {
        didSet {
            isLoginEnabled = !isEmailEmpty && !isPasswordEmpty
        }
    }
    
    private var isPasswordEmpty: Bool = true {
        didSet {
            isLoginEnabled = !isEmailEmpty && !isPasswordEmpty
        }
    }
    
    private var isLoginEnabled: Bool = false {
        didSet {
            loginButton.isEnabled = isLoginEnabled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.addTarget(self, action: #selector(didChangeTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangeTextField), for: .editingChanged)
    }

    @objc func didChangeTextField(_ sender: UITextField) {
        if sender == emailTextField {
            isEmailEmpty = sender.text?.isEmpty ?? true
        }
        
        if sender == passwordTextField {
            isPasswordEmpty = sender.text?.isEmpty ?? true
        }
    }

    @IBAction func didTapLogin(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { user, error in
            if let user {
                self.userDidLogged()
            }
            
            if let error {
                debugPrint(error)
            }
        }
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    private func userDidLogged() {
        userDefaults.save(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        
        let homeViewController = HomeViewController()
        view.window?.rootViewController = UINavigationController(rootViewController: homeViewController)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
