//
//  NewsModel.swift
//  SteamNews
//
//  Created by Winky51 on 23.09.2024.
//

import Foundation


struct Newsitems {
    let title: String
    let author: String
    let url: String
    let contents: String
    let date: Double
    let id: String
    
    init(newsItems: [String: Any]) {
        self.title = newsItems["title"] as? String ?? "No data newsitem"
        self.author = newsItems["author"] as? String ?? "No data"
        self.url = newsItems["url"] as? String ?? ""
        self.contents = newsItems["contents"] as? String ?? ""
        self.date = newsItems["date"] as? Double ?? 0
        self.id = String(newsItems["appid"] as? Int ?? 404)
    }
    
    
    static func getGameNews(_ value: Any) -> [Newsitems]{
        var news: [Newsitems] = []
        if let data = value as? [String: Any]{
            if let appnews = data["appnews"] as? [String: Any] {
                if let newsitems = appnews["newsitems"] as? [[String: Any]] {
                    news = newsitems.map {Newsitems(newsItems: $0)}
                    print(news)
                }
            }
        }
        return news
        
    }
}


