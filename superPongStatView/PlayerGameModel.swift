//
//  PlayerGameModel.swift
//  superPongStats
//
//  Created by Nathan Stowell on 1/9/15.
//  Copyright (c) 2015 OnePixelOff. All rights reserved.
//

import Foundation

public class PlayerGameModel: NSObject, Printable {
    public var gameId: Int?
    public var position: Int?
    public var playerId: Int?
    public var killerId: Int?
    public var gameTitle: String?
    
    init( playerid:Int, playerPosition:Int, gameid:Int, killerid:Int)
    {
        self.playerId = playerid
        self.position = playerPosition
        self.gameId = gameid
        self.killerId = killerid
        self.gameTitle = "Test"
    }
}
