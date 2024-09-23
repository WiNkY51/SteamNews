//
//  NewsModel.swift
//  SteamNews
//
//  Created by Winky51 on 23.09.2024.
//

import Foundation

struct NewsModel: Decodable {
    let appnews: AppNews
    
}

struct AppNews: Decodable {
    let appid: Int
    let newsitems: [Newsitems]
}

struct Newsitems: Decodable {
    let title: String
    let url: URL
    let author: String
}
