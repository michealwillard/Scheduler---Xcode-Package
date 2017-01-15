//
//  SignupViewController.swift
//  Scheduler
//
//  Created by Micheal Willard on 11/27/16.
//  Copyright © 2016 Micheal Willard. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPhone: UITextField!

    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textPasswordConfirm: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Buttons
    @IBAction func signupTapped(_ sender: UIButton) {
        // Get the values from the text fields
//        let name:NSString = textName.text! as NSString
//        let email:NSString = textEmail.text! as NSString
//        let phone:NSString = textPhone.text! as NSString
//        let password:NSString = textPassword.text! as NSString
//        let confirm_password:NSString = textPasswordConfirm.text! as NSString
        
        let name = textName.text ?? ""
        let email = textEmail.text ?? ""
        let phone = textPhone.text ?? ""
        let password = textPassword.text ?? ""
        let confirm_password = textPasswordConfirm.text ?? ""
        
        if ( email.isEqual("") || password.isEqual("") || name.isEqual("") ) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Can't Create Account"
            alertView.message = "Name, email and password are required"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
        else if ( !password.isEqual(confirm_password) ) {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Can't Create Account"
            alertView.message = "Your passwords don't match"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
        else {
            //  CALL POST HERE
            var request = URLRequest(url: URL(string: "https://hw3api.appspot.com/player")!)
            request.httpMethod = "POST"
            
            // curl --data "name=Micheal Willard" --data "email=michealwillard@gmail.com" --data "phone=206-605-4751" --data "password=spacecheese" -H "Accept: application/json" https://hw3api.appspot.com/player
            
            
            let postString = "name=" + name + "&email=" + email + "&phone=" + phone + "&password=" + password
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // check for fundamental networking error
                guard let data = data, error == nil else {
                    print("error=\(error)")
                    return
                }
                // check for http errors
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
            }
            task.resume()
            self.dismiss(animated: true, completion: nil)

        }
    }
    
    
    @IBAction func goto_login(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        //  delegate method
        textField.resignFirstResponder()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
