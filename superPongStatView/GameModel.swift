//
//  GameModel.swift
//  superPongStats
//
//  Created by Nathan Stowell on 12/31/14.
//  Copyright (c) 2014 OnePixelOff. All rights reserved.
//

import Foundation

public class GameModel: NSObject, Printable {
    public var title:String?
    public var winner: Int?
    public var active:Bool?
    public var id:Int?
    
    
    init(gameId:Int, gameTitle:String, gameWinner:Int, isActive:Bool)
    {
        id = gameId
        title = gameTitle
        winner = gameWinner
        active = isActive
    }
}