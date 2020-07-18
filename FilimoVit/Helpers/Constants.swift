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
}

enum Color {
    static let primaryColor = UIColor(red: 0.22, green: 0.58, blue: 0.29, alpha: 1.0)
    static let secondaryColor = UIColor.lightGray

    // A visual way to define colours within code files is to use #colorLiteral
    // This syntax will present you with colour picker component right on the code line
    static let tertiaryColor = #colorLiteral(red: 0.22, green: 0.58, blue: 0.29, alpha: 1.0)
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
