//
//  PlayerModel.swift
//  SuperPong
//
//  Created by Nathan Stowell on 12/20/14.
//  Copyright (c) 2014 OnePixelOff. All rights reserved.
//

import Foundation

public class PlayerModel: Serializable, Printable {
    public let id: Int
    public let name: String
    public var slogan: String
    public let wins: Int
    public let totalGames: Int
    public let mostKilled: String
    public let mostKilledBy: String
    public var rank: Int
    public var isInCurrentGame: Bool
    
    init(id: Int?, name: String?, slogan: String?, rank: Int?, wins: Int?, totalGames:Int?, mostKilled:String?, mostKilledBy:String?) {
        self.id = id ?? 0
        self.name = name ?? ""
        self.slogan = slogan ?? ""
        self.rank = rank ?? 0
        self.wins = wins ?? 0
        self.totalGames = totalGames ?? 0
        self.mostKilled = mostKilled ?? ""
        self.mostKilledBy = mostKilledBy ?? ""
        self.isInCurrentGame = false
    }
    
    public func setSlogan(newSlogan:String){
        slogan = newSlogan
    }
}