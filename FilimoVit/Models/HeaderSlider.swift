//
//  HeaderSlider.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/18/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import Foundation

struct HeaderSlider: Base {
    
    var id: Int
    var theme: VitrinItemTheme
    let list: [HeaderSliderItem]
    
    enum CodingKeys: String, CodingKey {
        case id
        case theme
        case list = "headersliders"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        theme = try container.decode(VitrinItemTheme.self, forKey: .theme)
        let listContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .list)
        list = try listContainer.decode([HeaderSliderItem].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {}
    
}

extension HeaderSlider {
    
    struct HeaderSliderItem: Codable {
        
        let id: Int
        let imageURL: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case imageURL = "pic"
        }
        
    }
    
}
