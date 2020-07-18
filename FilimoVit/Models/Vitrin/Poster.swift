//
//  Poster.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/17/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import Foundation

struct Poster: Base {
    
    var id: Int
    var theme: VitrinItemTheme
    let title: String
    let list: [PosterItem]
    
    enum CodingKeys: String, CodingKey {
        case id
        case theme
        case title = "link_text"
        case list = "posters"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        theme = try container.decode(VitrinItemTheme.self, forKey: .theme)
        title = try container.decode(String.self, forKey: .title)
        let listContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .list)
        list = try listContainer.decode([PosterItem].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {}
    
}

extension Poster {
    
    struct PosterItem: Codable {
        
        let id: Int
        let imageURL: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case imageURL = "pic"
        }
        
    }
    
}
