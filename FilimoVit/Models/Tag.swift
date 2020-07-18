//
//  Tag.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/17/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import Foundation

struct Tag: Base {
    
    var id: Int
    var theme: VitrinItemTheme
    let list: [TagItem]
    
    enum CodingKeys: String, CodingKey {
        case id
        case theme
        case list = "taglists"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        theme = try container.decode(VitrinItemTheme.self, forKey: .theme)
        let listContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .list)
        list = try listContainer.decode([TagItem].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {}
    
}

extension Tag {
    
    struct TagItem: Codable {
        
        let id: Int
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
        }
        
    }
    
}
