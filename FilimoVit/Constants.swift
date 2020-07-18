//
//  Constants.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/17/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import Foundation

enum API {
    #if DEBUG
    static let baseURL = "https://www.filimo.com/_/api/fa/v1"
    #else
    static let baseURL = "https://www.filimo.com/_/api/fa/v1"
    #endif
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
