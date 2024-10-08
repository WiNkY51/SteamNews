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
    private let webMenager = WebMenager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        icon.layer.cornerRadius = 25
        

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let news = sender as? Newsitems else { return }
        let webVC = segue.destination as? WebViewController
        webVC?.presentNews(news.url)
        
        
    }
    

}

extension NewsViewController {
    func fetchNews(_ gameId: String) {
        var data: GameNews!
        webMenager.fetch(GameNews.self, gameId) {[weak self] result in
            guard let self else { return }
            switch result {
                case .success(let news):
                    data = news
                    print(data ?? "no Data")
                    self.gameNews = data.appnews.newsitems
                    tableView.reloadData()
                case .failure(let failure):
                    print("News - \(failure)")
            }
        }
    }
    
    func fetchIcon(_ url: URL) {
        webMenager.fetchIcon(url) {[weak self] result in
            guard let self else { return }
            switch result {
                case .success(let image):
                    self.icon.image = UIImage(data: image)
                case .failure(let failure):
                    print(failure)
            }
        }
    }
}
