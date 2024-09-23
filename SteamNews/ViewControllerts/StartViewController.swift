//
//  StartViewController.swift
//  SteamNews
//
//  Created by Winky51 on 24.09.2024.
//

import UIKit

final class StartViewController: UIViewController {

    private let url = URL(string: "https://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=252490&count=3&maxlength=300")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNews()
    }

    

    private func fetchNews() {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data, let response else {
                    print(error ?? "No error description")
                    return
                }
                
                print(response)
                
                do {
                    let news = try JSONDecoder().decode(NewsModel.self, from: data)
                    print(news)
                } catch {
                    print(error)
                }
                
                print()
                
            }.resume()
    }
}
