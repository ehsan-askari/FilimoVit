//
//  Base.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/17/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import Foundation

protocol Base: Codable {
    
    var id: Int {get set}
    var theme: VitrinItemTheme {get set}
    
}
