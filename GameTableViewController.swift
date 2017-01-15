//
//  GameTableViewController.swift
//  Scheduler
//
//  Created by Micheal Willard on 11/5/16.
//  Copyright © 2016 Micheal Willard. All rights reserved.
//

import UIKit

class GameTableViewController: UITableViewController {
    
    // MARK: Properties
    var games = [Game]()
//    var players = [Player]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Here is where we call the GET to the server to populate the local Game and Player objects
        loadSampleGames()
        print("games loaded")
        print(self.games)
        //loadSamplePlayers()
        
    }
    
    func loadSampleGames() {
        
        // Make GET call
        let requestURL: NSURL = NSURL(string: "https://hw3api.appspot.com/game")!
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
                    if let gamelist = json as? [[String: AnyObject]] {
                        for game in gamelist {
                            if let name = game["opp_name"] as? String {
                                if let location = game["location"] as? String {
                                    if let date = game["date"] as? String {
                                        if let time = game["time"] as? String {
                                            let id = game["key"] as? Int
                                            let attending = game["attending"] as? [Int]
                                            let not_attending = game["not_attending"] as? [Int]
                                            let newGame = Game(game_id: id!, opp_name: name, location: location, date: date, time: time, attending: attending!, not_attending: not_attending!)
                                            print("game: ", newGame?.opp_name as Any)
                                            print("atten: ", newGame?.attending as Any)
                                            self.games.append(newGame!)
                                            self.tableView.reloadData()
                                        }
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
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return games.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "GameTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GameTableViewCell
        
        // Fetches the appropriate game for the data source layout.
        // Change index to games[game_id]
        let game = games[indexPath.row]
        
        
        // Configure the cell...
        cell.oppLabel.text = game.opp_name
        cell.locationLabel.text = game.location
        cell.dateLabel.text = game.date
        cell.timeLabel.text = game.time
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            //let gameDetailViewController = segue.destination as! GameViewController
            let nav = segue.destination as! UINavigationController
            let GameViewController = nav.topViewController as! GameViewController
            
            // Get the cell that generated this segue.
            if let selectedGameCell = sender as? GameTableViewCell {
                let indexPath = tableView.indexPath(for: selectedGameCell)!
                let selectedGame = games[indexPath.row]
                GameViewController.game = selectedGame
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new game.")
        }
    }
    
    
     
     @IBAction func unwindToGameList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? GameAddViewController, let game = sourceViewController.game {
            // Add a new game.
            let newIndexPath = IndexPath(row: games.count, section: 0)
            games.append(game)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
        }
     }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



//        let game1 = Game(game_id: 5629499534213120, opp_name: "Diablos", location: "Steve Cox", date: "10-23-2016", time: "7:00 PM", attending: [5659313586569216], not_attending: [5639445604728832])!
//        print(game1)
//
//        let game2 = Game(game_id: 5634472569470976, opp_name: "Nationals", location: "Bannerwood Park",  date: "09-23-2016", time: "6:00 PM", attending: [5715999101812736], not_attending: [5639445604728832, 5639445604728839])!
//
//        let game3 = Game(game_id: 5707702298738688, opp_name: "Mets",  location: "Chief Sealth High School",  date: "10-23-2016", time: "7:00 PM", attending: [], not_attending: [])!
//
//        let game4 = Game(game_id: 5700305828184064, opp_name: "Rays",  location: "Bannerwood Park",  date: "7-30-2016", time: "6:00 PM", attending: [], not_attending: [])!
//
//        games += [game1, game2, game3, game4]
//print(games)

//func loadSamplePlayers() {
//    
//    // Add GET FUNCTIONS HERE
//    // Make GET call
//    //        let requestURL: NSURL = NSURL(string: "https://hw3api.appspot.com/game")!
//    //        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
//    //        let session = URLSession.shared
//    //        let task = session.dataTask(with: urlRequest as URLRequest) {
//    //            (data, response, error) -> Void in
//    //            let httpResponse = response as! HTTPURLResponse
//    //            let statusCode = httpResponse.statusCode
//    //            if (statusCode == 200) {
//    //                print("JSON Retrieved Successfully.")
//    //                do {
//    //                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
//    //                    if let gamelist = json as? [[String: AnyObject]] {
//    //                        for game in gamelist {
//    //                            if let name = game["opp_name"] as? String {
//    //                                if let location = game["location"] as? String {
//    //                                    if let date = game["date"] as? String {
//    //                                        if let time = game["time"] as? String {
//    //                                            let id = game["key"] as? Int
//    //                                            let newGame = Game(game_id: id!, opp_name: name, location: location, date: date, time: time, attending: [], not_attending: [])
//    //                                            self.games.append(newGame!)
//    //                                            self.tableView.reloadData()
//    //                                        }
//    //                                    }
//    //                                }
//    //                            }
//    //                        }
//    //                    }
//    //                }catch {
//    //                    print("Error with JSON: \(error)")
//    //                }
//    //            }
//    //        }
//    //        task.resume()
//    
//    
//    //        let player1 = Player(player_id: 5639445604728832, name: "Colin Webb", email: "colinzwebb@gmail.com", phone: "425-736-0961")
//    //        let player2 = Player(player_id: 5649391675244544, name: "Micheal Willard", email: "michealwillard@gmail.com", phone: "206-605-4751")
//    //        let player3 = Player(player_id: 5659313586569216, name: "Sam Gordon", email: "", phone: "425-555-5555")
//    //        let player4 = Player(player_id: 5668600916475904, name: "Ryan Tipper", email: "ryantipper@gmail.com", phone: "425-555-5555")
//    //        let player5 = Player(player_id: 5715999101812736, name: "Josh Schiefer", email: "joshschiefer@gmail.com", phone: "425-555-5555")
//    //        
//    //        players += [player1!, player2!, player3!, player4!, player5!]
//    
//    
//}
