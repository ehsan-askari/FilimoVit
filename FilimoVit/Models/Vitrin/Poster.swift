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
    let list: [PosterItem]
    
    enum CodingKeys: String, CodingKey {
        case id
        case theme
        case list = "posters"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        theme = try container.decode(VitrinItemTheme.self, forKey: .theme)
        let listContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .list)
        list = try listContainer.decode([PosterItem].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {}
    
}

extension Poster {
    
    struct PosterItem: Codable {
        
        let id: Int
        let imageURL: String
        let imageRatio: Float
        let autoPlayDuration: Float
        
        enum CodingKeys: String, CodingKey {
            case id
            case imageURL = "pic"
            case imageRatio = "pic_ratio"
            case autoPlayDuration = "autoplay_duration"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            imageURL = try container.decode(String.self, forKey: .imageURL)
            autoPlayDuration = Float(try container.decode(String.self, forKey: .autoPlayDuration)) ?? 0
            let temps = try container.decode(String.self, forKey: .imageRatio).split(separator: ":")
            imageRatio = Float(temps[1])! / Float(temps[0])!
        }
        
        func encode(to encoder: Encoder) throws {}
        
    }
    
}
