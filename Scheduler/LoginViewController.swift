//
//  LoginViewController.swift
//  Scheduler
//
//  Created by Micheal Willard on 11/27/16.
//  Copyright © 2016 Micheal Willard. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    // MARK: Properties
    var players = [Player]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSamplePlayers()
//        loadSamplePlayers(newPlayer: players)
//        print(self.players)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        let email:NSString = textEmail.text! as NSString
        let password:NSString = textPassword.text! as NSString
        var tempPassword:NSString = ""
        var tempId:NSInteger = 0
        var tempName:NSString = ""
        var emailExists = 0
        loadSamplePlayers()
        if (email.isEqual(to: "") || password.isEqual(to: "")) {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Login Error"
            alertView.message = "You must enter your email and password"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
        else {
//            loadSamplePlayers(newPlayer: players)
            print("Login Tapped w/ input")
            print(email)
            for p in players {
//                print(p.email)
//                print(p.password)
                if p.email == email as String {
                    tempPassword = p.password as NSString
                    tempId = p.player_id as NSInteger
                    tempName = p.name as NSString
                    emailExists = 1
                }
            }
            if emailExists == 1 {
                if password == tempPassword {
                    print("Login Success")
                    let prefs:UserDefaults = UserDefaults.standard
                    prefs.set(tempName, forKey: "USERNAME")
                    prefs.set(tempId, forKey: "PLAYERID")
                    prefs.set(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                        
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Password is incorrect"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                }
            }
            else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Email Address is incorrect"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
            }
        }
        
        //  Login Authentication Code
        
        
        // Redirect to Schedule
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadSamplePlayers() {
        // newPlayer: [Player]
        // Add GET FUNCTIONS HERE
        // Make GET call
                let requestURL: NSURL = NSURL(string: "https://hw3api.appspot.com/player")!
                let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
                let session = URLSession.shared
                let task = session.dataTask(with: urlRequest as URLRequest) {
                    (data, response, error) -> Void in
                    let httpResponse = response as! HTTPURLResponse
                    let statusCode = httpResponse.statusCode
                    if (statusCode == 200) {
                        print("JSON Retrieved Successfully.")
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                            if let playerlist = json as? [[String: AnyObject]] {
                                for player in playerlist {
                                    if let name = player["name"] as? String {
                                        if let password = player["password"] as? String {
                                            if let email = player["email"] as? String {
                                                let phone = player["phone"] as? String
                                                let id = player["key"] as? Int
                                                let newPlayer = Player(player_id: id!, name: name, email: email, phone: phone!, password: password)
                                                self.players.append(newPlayer!)
//                                                  self.reloadData()
//                                                self.tableView.reloadData()
                                                print(newPlayer?.name)
                                                print(newPlayer?.email)
                                            }
                                        }
                                    }
                                }
                            }
                        }catch {
                            print("Error with JSON: \(error)")
                        }
                    }
                }
                task.resume()
        
        
        //        let player1 = Player(player_id: 5639445604728832, name: "Colin Webb", email: "colinzwebb@gmail.com", phone: "425-736-0961")
        //        let player2 = Player(player_id: 5649391675244544, name: "Micheal Willard", email: "michealwillard@gmail.com", phone: "206-605-4751")
        //        let player3 = Player(player_id: 5659313586569216, name: "Sam Gordon", email: "", phone: "425-555-5555")
        //        let player4 = Player(player_id: 5668600916475904, name: "Ryan Tipper", email: "ryantipper@gmail.com", phone: "425-555-5555")
        //        let player5 = Player(player_id: 5715999101812736, name: "Josh Schiefer", email: "joshschiefer@gmail.com", phone: "425-555-5555")
        //        
        //        players += [player1!, player2!, player3!, player4!, player5!]
        
        
    }

}
