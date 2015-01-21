//
//  HipChatAPI.swift
//  superPongStatView
//
//  Created by Nathan Stowell on 1/20/15.
//  Copyright (c) 2015 OnePixelOff. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

public class HipChatAPI: NSObject {
    let baseAPIhost = "https://api.hipchat.com/v1/rooms"
    let token = "3cad0e0608d47cf1231c19ca6d3c3e"
    let roomId = "833163"
    let postColor = "purple"
    
    private var players = [PlayerModel]()
    
    private var games = [GameModel]()
    
    //1
    public class var sharedInstance: HipChatAPI {
        //2
        struct Singleton {
            //3
            static let instance = HipChatAPI()
        }
        //4
        return Singleton.instance
    }
    
    public func postTheWah(){
        let url = baseAPIhost + "/message?format=json&auth_token=" + token + "&room_id=" + roomId + "&message_format=text&color=" + postColor + "&from=SuperPongApp&message=@here+Let+Us+(wah)"
        Alamofire.request(.POST, url, parameters: nil)
            .response { (request, response, data, error) in
                println(request)
                println(response)
                println(error)
        }
    }
}