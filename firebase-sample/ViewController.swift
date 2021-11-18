//
//  ViewController.swift
//  firebase-sample
//
//  Created by daimon on 2021/11/15.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailRegisterTextField: UITextField!
    @IBOutlet weak var passwordRegisterTextField: UITextField!
    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneCodeTextField: UITextField!
    
    private var user: User?
    private var verificationId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func emailRegisterButtonTapped(_ sender: Any) {
        let email = emailRegisterTextField.text ?? ""
        let password = passwordRegisterTextField.text ?? ""
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            self.user = result?.user
            print(self.user?.uid)
        }
    }
    
    @IBAction func emailLoginButtonTapped(_ sender: Any) {
        let email = emailLoginTextField.text ?? ""
        let password = passwordLoginTextField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            self.user = result?.user
            print(self.user?.uid)
        }
    }
    
    @IBAction func phoneRegisterButtonTapped(_ sender: Any) {
        let phone = phoneTextField.text ?? ""
        // TODO: 既に使われている電話番号かどうかを確かめる方法はないのか？
        
        
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { verificationId, error in
            self.verificationId = verificationId ?? ""
        }
    }
    
    @IBAction func phoneCodeButtonTapped(_ sender: Any) {
        let code = phoneCodeTextField.text ?? ""
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.verificationId, verificationCode: code)
        self.user?.link(with: credential, completion: { result, error in
            print(error)
        })
    }
}

