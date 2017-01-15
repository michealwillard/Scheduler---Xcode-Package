//
//  GameAddViewController.swift
//  Scheduler
//
//  Created by Micheal Willard on 11/5/16.
//  Copyright © 2016 Micheal Willard. All rights reserved.
//

import UIKit

class GameAddViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    // MARK:  Properties
    
    @IBOutlet weak var opp_nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    /*
     either passed by `GameTableViewController` in `prepareForSegue(_:sender:)`
     
     This value is constructed as part of adding a new game.
     */
    var game: Game?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks
        opp_nameTextField.delegate = self
        locationTextField.delegate = self
        dateTextField.delegate = self
        timeTextField.delegate = self
        
        //  Disable the Save Button
        checkValidGameName()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidGameName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    func checkValidGameName() {
        // Disable the Save button if the text field is empty.
        
        let opp_nameText = opp_nameTextField.text ?? ""
        /*
        let locationText = locationTextField.text ?? ""
        let dateText = dateTextField.text ?? ""
        let timeText = timeTextField.text ?? ""
        if opp_nameText.isEmpty || locationText.isEmpty || dateText.isEmpty || timeText.isEmpty {
            saveButton.isEnabled = false
        }
        */
        saveButton.isEnabled = !opp_nameText.isEmpty
    }
    
    
    
    // MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    
    }


    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as AnyObject? {
            let opp_name = opp_nameTextField.text ?? ""
            let location = locationTextField.text ?? ""
            let date = dateTextField.text ?? ""
            let time = timeTextField.text ?? ""
            
            // Set the game to be passed to GameTableViewController after the unwind segue.
            game = Game(game_id: 0, opp_name: opp_name, location: location, date: date, time: time, attending: [], not_attending: [])
            
            //  CALL POST HERE
            var request = URLRequest(url: URL(string: "https://hw3api.appspot.com/game")!)
            request.httpMethod = "POST"
            
            let postString = "opp_name=" + opp_name + "&date=" + date + "&time=" + time + "&location=" + location
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
        }
    }
    
    // MARK:  Actions
    
    /*@IBAction func setDefaultLabelText(_ sender: UIButton) {
     // add the save function?
     oppNameLabel.text = "Default Text"
     }*/
    
}
