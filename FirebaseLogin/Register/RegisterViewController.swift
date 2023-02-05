//
//  RegisterViewController.swift
//  FirebaseLogin
//
//  Created by Manuel Rodriguez Sebastian on 26/1/23.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            registerButton.isEnabled = false
        }
    }
    
    private var isEmailEmpty: Bool = true {
        didSet {
            isRegisterEnabled = !isEmailEmpty && !isPasswordEmpty
        }
    }
    
    private var isPasswordEmpty: Bool = true {
        didSet {
            isRegisterEnabled = !isEmailEmpty && !isPasswordEmpty
        }
    }
    
    private var isRegisterEnabled: Bool = false {
        didSet {
            registerButton.isEnabled = isRegisterEnabled
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
    
    @IBAction func didTapRegister(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { user, error in
            if let user {
                debugPrint("REGISTERED")
            }
            
            if let error {
                debugPrint(error)
            }
        }
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
