//
//  NewsViewController.swift
//  SteamNews
//
//  Created by Winky51 on 08.10.2024.
//

import UIKit

final class NewsViewController: UITableViewController {
    
    @IBOutlet weak var icon: UIImageView!
    
    private var gameNews: [Newsitems] = []
    private let networkManager = NetworkManager.shared


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameNews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsPost = gameNews[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
        guard let cell = cell as? NewsCell else { return UITableViewCell() }
        
        cell.config(newsPost)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = gameNews[indexPath.row]
        performSegue(withIdentifier: "showWebView", sender: news)
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let news = sender as? Newsitems else { return }
        let contentVC = segue.destination as? ContentViewController
        
        contentVC?.titleText = news.title
        contentVC?.contentText = news.contents
    }
}

extension NewsViewController {
    func fetchNews(_ gameId: String) {
        networkManager.fetchNews(gameId) {[unowned self] result in
            
            switch result {
                case .success(let data):
                    gameNews = data
                    tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func fetchIcon(_ appid: String) {
        networkManager.fetchData(appid) {[unowned self] result in
            switch result {
                case .success(let image):
                    icon.image = UIImage(data: image)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
