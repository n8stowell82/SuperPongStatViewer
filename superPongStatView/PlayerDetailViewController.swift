//
//  PlayerDetailViewController.swift
//  SuperPong
//
//  Created by Nathan Stowell on 12/21/14.
//  Copyright (c) 2014 OnePixelOff. All rights reserved.
//

import UIKit
import SuperPongCore


class PlayerDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func backToPlayersDetailViewController(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var playerSlogan: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var gameTable: UITableView!
    
    var player:PlayerModel?
    
    var games = [PlayerGameModel]()
    
    let accentColor = UIColor(red: 0.98, green: 0.53, blue: 0.0, alpha: 1.0)
    
    var playerId:Int?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, atIndex: 0)

        // Do any additional setup after loading the view.
        let total = self.player?.totalGames ?? -1
        let wins = self.player?.wins ?? 0
        let losses = -1 // abs( total - wins )
        let slogan = self.player?.slogan ?? ""
        playerId = self.player?.id ?? -1
        
        let rank  = self.player?.rank.description ?? "0"
        
        playerNameLabel.text = self.player?.name ?? ""
        playerSlogan.text = "\"" + slogan + "\""
        
        //start button setup
        self.backButton.layer.borderWidth = 1
        self.backButton.layer.cornerRadius = 5
        self.backButton.layer.borderColor = accentColor.CGColor
        
        gameTable.dataSource = self
        gameTable.delegate = self
        gameTable.backgroundColor = UIColor.clearColor()
        gameTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        gameTable.separatorStyle = .None
        gameTable.rowHeight = 33.0

        loadTableData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTableData(){
        GamePlayersAPI.sharedInstance.loadAllGamesForPlayer( playerId!, success: { (data, error) -> Void in
            self.games = data!
            self.gameTable.reloadData()
        })
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Mark: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let game = self.games[indexPath.row]
        cell.selectionStyle = .None
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = accentColor
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 20.0)
        cell.tintColor = accentColor
        cell.textLabel?.text = game.gameTitle! + "test"
        
        return cell
    }
    
    func colorForIndex(index: Int) -> UIColor {
        let gameCount = games.count - 1
        if (gameCount > 0) {
            let val = (CGFloat(index) / CGFloat(gameCount)) * 0.4
            return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
        }else {
            return UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        }
    }
    
    // Mark: - Table view delegate
    
    
    func tableView(tableView: UITableView, willDisplayCell cell:UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //        cell.backgroundColor = colorForIndex(indexPath.row)
        cell.backgroundColor = UIColor.clearColor()
    }
}
