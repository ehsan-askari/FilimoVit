//
//  Constants.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/17/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import Foundation
import UIKit

enum API {
    #if DEBUG
    static let baseURL = "https://www.filimo.com/_/api/fa/v1"
    #else
    static let baseURL = "https://www.filimo.com/_/api/fa/v1"
    #endif
    
    static let defaultHeaders = ["JsonType": "simple", "Content-Type": "application/json"]
    
    enum Endpoint {
        static let vitrin = "/movie/movie/list/tagid/1"
    }
}


enum Color {
    static let primary = #colorLiteral(red: 0.1516066194, green: 0.1516112089, blue: 0.1516087353, alpha: 1)
    static let secondary = #colorLiteral(red: 1, green: 0.7553820014, blue: 0, alpha: 1)
    static let gray = #colorLiteral(red: 0.8505141139, green: 0.8506365418, blue: 0.853792727, alpha: 1)
}

enum Message {
    static let noConnection = "عدم اتصال به شبکه!"
    static let unknown = "خطای نامشخص!"
}

enum VitrinItemType: String, Codable {
    case HeaderSlider = "headerslider"
    
    case Poster = "poster"
    
    case Movie = "movie"
    
    case TVChannel = "tvchannels"
    
    case Tag = "tags"
}

enum VitrinItemTheme: String, Codable {
    case HeaderSlider = "headerslider"
    
    case Theater = "theater"
    case Brick = "brick"
    
    case Thumbnail = "thumbnail"
    case Thumbplay = "thumbplay"
    
    case LiveTV = "livetvs"
    
    case Tag = "tags"
}
