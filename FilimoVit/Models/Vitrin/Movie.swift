//
//  Movie.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/17/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import Foundation

struct Movie: Base {
    
    var id: Int
    var theme: VitrinItemTheme
    let title: String
    let list: [MovieItem]
    
    enum CodingKeys: String, CodingKey {
        case id
        case theme
        case title = "link_text"
        case list = "movies"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        theme = try container.decode(VitrinItemTheme.self, forKey: .theme)
        title = try container.decode(String.self, forKey: .title)
        let listContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .list)
        list = try listContainer.decode([MovieItem].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {}
    
}

extension Movie {
    
    struct MovieItem: Codable {
        
        let id: Int
        let title: String
        let titleEn: String?
        let isSerial: Bool
        let isHD: Bool
        let imageURL: String
        let coverImageURL: String?
        let avgRatePercentage: String
        let country: String?
        let imdbRate: Float?
        let categoryTitle: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case title = "movie_title"
            case titleEn = "movie_title_en"
            case serial
            case isSerial = "enable"
            case isHD = "HD"
            case pic
            case movie_img_m
            case thumbplay
            case thumbplay_img_m
            case coverImageURL = "movie_cover"
            case avgRatePercentage = "avg_rate_label"
            case country
            case imdbRate = "imdb_rate"
            case categoryTitle = "cat_title_str"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            titleEn = try? container.decodeIfPresent(String.self, forKey: .titleEn)
            let serialContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .serial)
            isSerial = try serialContainer.decode(Bool.self, forKey: .isSerial)
            isHD = try container.decode(Bool.self, forKey: .isHD)
            if let thumbplayContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbplay){
                imageURL = try thumbplayContainer.decode(String.self, forKey: .thumbplay_img_m)
            }
            else{
                let picContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .pic)
                imageURL = try picContainer.decode(String.self, forKey: .movie_img_m)
            }
            coverImageURL = try? container.decodeIfPresent(String.self, forKey: .coverImageURL)
            avgRatePercentage = try container.decode(String.self, forKey: .avgRatePercentage)
            country = try? container.decodeIfPresent(String.self, forKey: .country)
            let iR = Float(try container.decode(String.self, forKey: .imdbRate))
            imdbRate = iR == Float(0) ? nil : iR
            categoryTitle = try? container.decodeIfPresent(String.self, forKey: .categoryTitle)
        }
        
        func encode(to encoder: Encoder) throws {}
        
    }
    
}
