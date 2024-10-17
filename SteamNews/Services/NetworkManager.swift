//
//  WebMenager.swift
//  SteamNews
//
//  Created by Winky51 on 08.10.2024.
//

import Foundation
import Alamofire

enum GamesPreset: CaseIterable {
    case rust
    case warthunder
    case crosout
    case ets2
    
    var title: String {
        switch self {
            case .rust:
                "Rust"
            case .warthunder:
                "War Thunder"
            case .crosout:
                "Crossout"
            case .ets2:
                "Euro truck simulator 2"
        }
    }
    var id: String {
        switch self {
            case .rust: "252490"
            case .warthunder: "236390"
            case .crosout: "386180"
            case .ets2: "227300"
        }
    }
                
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchNews(_ gameId: String, completion: @escaping(Result<[Newsitems], AFError>) -> Void) {
        let url =  "https://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=\(gameId)&count=7&maxlength=10000"
        
        AF.request(url)
            .validate()
            .responseJSON { value in
                switch value.result {
                    case .success(let json):
                        let gameNews = Newsitems.getGameNews(json)
                        print(gameNews)
                       completion(.success(gameNews))
                    case .failure(let error):
                        print(error)
                }
            }
    }
    
    func fetchData(_ appid: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        let url = "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/\(appid)/header.jpg"
        
        AF.request(url)
            .validate()
            .responseData { value in
                switch value.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
}
