//
//  WebMenager.swift
//  SteamNews
//
//  Created by Winky51 on 08.10.2024.
//

import Foundation
enum NetworkError: Error {
    case noData
    case networkError
    case decodingError
    case invalidURL
}
    
final class WebMenager {
    static let shared = WebMenager()
    

    func fetchIcon(_ url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let iconData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(iconData))
            }
        }
    }
    
    func fetch <T: Decodable>(_ type: T.Type, _ gameId: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=\(gameId)&count=7&maxlength=300") else {
            completion(.failure(.invalidURL))
            return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error ?? "No error data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    init() {}
}
