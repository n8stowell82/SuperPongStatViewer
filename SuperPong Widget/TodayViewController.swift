//
//  TodayViewController.swift
//  SuperPong Widget
//
//  Created by Nathan Stowell on 1/19/15.
//  Copyright (c) 2015 OnePixelOff. All rights reserved.
//

import UIKit
import NotificationCenter
import SuperPongCore

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var wahButton: UIButton!
    
    @IBAction func wahButtonHit(sender: AnyObject) {
        handleWah()
    }
    
    @IBOutlet weak var playerTable: UITableView!
    
    var players = [PlayerModel]()
    var ranks = [Int]()
    
    let accentColor = UIColor(red: 0.98, green: 0.53, blue: 0.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        playerTable.dataSource = self
        playerTable.delegate = self
        playerTable.backgroundColor = UIColor.clearColor()
        playerTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        playerTable.separatorStyle = .None
        playerTable.rowHeight = 33.0
        
        loadTableData()
        
        //start button setup
        self.wahButton.layer.borderWidth = 1
        self.wahButton.layer.cornerRadius = 5
        self.wahButton.layer.borderColor = accentColor.CGColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    func handleWah(){
        println("WAH!");
        HipChatAPI.sharedInstance.postTheWah()
    }
    
    func loadTableData(){
        GamePlayersAPI.sharedInstance.loadAllPlayers({ (data, error) -> Void in
            
            self.players = data!
            self.ranks.removeAll(keepCapacity: false)
            self.populateRanks()
            self.calculatePlayersRank()
            
            self.players.sort({ $0.rank < $1.rank })
            
            self.playerTable.reloadData()
        })
    }
    
    // Mark: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let player = self.players[indexPath.row]
        cell.selectionStyle = .None
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = accentColor
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 20.0)
        cell.tintColor = accentColor
        cell.textLabel?.text = (indexPath.row + 1).description + ".  " + player.name
        
        return cell
    }
    
    func colorForIndex(index: Int) -> UIColor {
        let playerCount = players.count - 1
        if (playerCount > 0) {
            let val = (CGFloat(index) / CGFloat(playerCount)) * 0.4
            return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
        }else {
            return UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        }
    }
    
    func AddPlayerToGame(player: PlayerModel) {
        let index = (players as NSArray).indexOfObject(player)
        if index == NSNotFound { return }
        
        // could removeAtIndex in the loop but keep it here for when indexOfObject works
        
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
        let cell = playerTable.cellForRowAtIndexPath(indexPathForRow)
        players.append(player)
        cell?.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0)
        
    }
    
    // Mark: - Table view delegate
    
    
    func tableView(tableView: UITableView, willDisplayCell cell:UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.backgroundColor = colorForIndex(indexPath.row)
        cell.backgroundColor = UIColor.clearColor()
    }
    
    //Mark helper
    
    private func populateRanks() ->Void{
        if ranks.count == 0 {self.ranks.append(0)}
        for player in self.players{
            for rank in self.ranks{
                if player.wins > rank{
                    if !contains(ranks, player.wins){
                        self.ranks.append(player.wins)
                    }
                }
            }
        }
        self.ranks.sort({ $0 > $1 })
    }
    
    private func calculatePlayersRank() ->Void{
        var rank = 0
        for player in players{
            var rankIndex = 0
            for rank in ranks{
                rankIndex++
                if(player.wins == rank){
                    player.rank = rankIndex
                }
            }
        }
    }
    
}
