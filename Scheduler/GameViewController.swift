//
//  GameViewController.swift
//  Scheduler
//
//  Created by Micheal Willard on 11/4/16.
//  Copyright © 2016 Micheal Willard. All rights reserved.
//

import UIKit
import MapKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    // MARK:  Properties
    @IBOutlet weak var opp_nameLabelText: UILabel!
    @IBOutlet weak var locationNameLabelText: UILabel!
    @IBOutlet weak var dateLabelText: UILabel!
    @IBOutlet weak var timeLabelText: UILabel!
    @IBOutlet weak var playersLabelText: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var attendanceSwitch: UISwitch!


    
    var game: Game?
    var setSwitch = 0
    var tempPID = 0
    let prefs:UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks
        //oppTextField.delegate = self
        
        if let game = game {
            navigationItem.title = game.opp_name
            opp_nameLabelText.text = game.opp_name
            locationNameLabelText.text = game.location
            dateLabelText.text = game.date
            timeLabelText.text = game.time
            print(game.attending)
            print(game.game_id)
//            playersLabelText.text = String(describing: game.attending)
//            let prefs:UserDefaults = UserDefaults.standard
            let tempPID = prefs.value(forKey: "PLAYERID")! as! Int
            for p_id in game.attending {
                if p_id == tempPID {
                    print("Player id matches attending")
                    setSwitch = 1
                }
            }
            if setSwitch == 1 {
                playersLabelText.text = "You are Attending"
                attendanceSwitch.isOn = true
            }
            else {
                playersLabelText.text = "You are Not Attending"
                attendanceSwitch.isOn = false
            }
        }
        
        let locationString = (game?.location)! + " ,WA"
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationString) { [weak self] placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let mark = MKPlacemark(placemark: placemark)
                
                if var region = self?.mapView.region {
                    region.center = location.coordinate
                    region.span.longitudeDelta /= 24.0
                    region.span.latitudeDelta /= 24.0
                    self?.mapView.setRegion(region, animated: true)
                    self?.mapView.addAnnotation(mark)
                    self?.mapView.showsUserLocation = true
                }
            }
        }
        
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
        
    }
    
    
    
    // MARK:  Actions
    
    @IBAction func switchChanged(_ sender: Any) {
        let gameString = String(describing: game!.game_id)
        print(gameString)
        let playerString = String(describing: prefs.value(forKey: "PLAYERID")!)
        print(playerString)
        if attendanceSwitch.isOn == true {
            //  ADD to attending, DELETE from not_attending
            //  https://hw3api.appspot.com/a/game/id/player/id
            var request = URLRequest(url: URL(string: "https://hw3api.appspot.com/a/game/" + gameString + "/player/" + playerString)!)
            request.httpMethod = "PUT"
            
//            url += game?.game_id + "/player/" + tempPID
//            request.httpBody = postString.data(using: .utf8)
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
            playersLabelText.text = "You are Attending"
        }
        else {
            //  DELETE from attending, ADD to not_attending
            //  https://hw3api.appspot.com/na/game/id/player/id
            var request = URLRequest(url: URL(string: "https://hw3api.appspot.com/na/game/" + gameString + "/player/" + playerString)!)
            request.httpMethod = "PUT"
            
            //            url += game?.game_id + "/player/" + tempPID
            //            request.httpBody = postString.data(using: .utf8)
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
            playersLabelText.text = "You are Not Attending"
        }
    }
    
    /*@IBAction func setDefaultLabelText(_ sender: UIButton) {
        // add the save function?
        oppNameLabel.text = "Default Text"
    }*/

}

