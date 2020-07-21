//
//  VitrinItem.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/17/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import Foundation

enum VitrinItem: Codable {
    
    case headerSlider(HeaderSlider)
    case poster(Poster)
    case movie(Movie)
    case tag(Tag)
    case unsupported
    
    enum CodingKeys: String, CodingKey {
        case type = "output_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch VitrinItemType.init(rawValue: type) {
        case .HeaderSlider:
            self = .headerSlider(try HeaderSlider(from: decoder))
            break
        case .Poster:
            self = .poster(try Poster(from: decoder))
            break
        case .Movie:
            self = .movie(try Movie(from: decoder))
            break
        case .Tag:
            self = .tag(try Tag(from: decoder))
            break
        default:
            self = .unsupported
        }
    }
    
    func encode(to encoder: Encoder) throws {}
    
}
