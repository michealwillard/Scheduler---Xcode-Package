//
//  LoginViewController.swift
//  Scheduler
//
//  Created by Micheal Willard on 11/26/16.
//  Copyright © 2016 Micheal Willard. All rights reserved.
//
//
//import UIKit
//
//class LoginViewController: UIViewController, UITextFieldDelegate {
//    
//    
//    // MARK: Properties
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    
//    @IBOutlet weak var LoginButton: UIButton!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Handle the text field's user input through delegate callbacks
//        emailTextField.delegate = self
//        passwordTextField.delegate = self
//        
//        //  Disable the Login Button
//        checkValidLogin()
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    // MARK:  UITextFieldDelegate
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        // Hide the keyboard.
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        checkValidLogin()
//    }
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // Disable the login button while editing.
//        LoginButton.isEnabled = false
//    }
//    
//    func checkValidLogin() {
//        // Disable the Save button if the texts field are empty.
//        
//        let emailText = emailTextField.text ?? ""
//        let passwordText = passwordTextField.text ?? ""
//        if emailText.isEmpty || passwordText.isEmpty {
//            LoginButton.isEnabled = false
//            print("if email= " + emailText)
//            print("if pword= " + passwordText)
//        }
//        else {
//            LoginButton.isEnabled = true
//            print("else email= " + emailText)
//            print("else pword= " + passwordText)
//        }
////        if emailText.isEmpty {
////            print("if email= " + emailText)
////            if passwordText.isEmpty {
////                print("if login= " + passwordText)
////                LoginButton.isEnabled = false
////            }
////        }
////        else {
////            print("else email= " + emailText)
////            print("else login= " + passwordText)
////            LoginButton.isEnabled = true
////        }
//    }
//    
//}
