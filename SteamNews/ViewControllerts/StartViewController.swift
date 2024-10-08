//
//  StartViewController.swift
//  SteamNews
//
//  Created by Winky51 on 08.10.2024.
//

import UIKit

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
    
    var icon: URL {
        switch self {
            case .rust:
                URL(string: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/252490/header.jpg?t=1724072904")!
            case .warthunder:
                URL(string: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/236390/header.jpg?t=1726558105")!
                
            case .crosout:
                URL(string: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/386180/header.jpg?t=1727940166")!
                
            case .ets2:
                URL(string: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/227300/header.jpg?t=1726766157")!
                
        }
    }
}

final class StartViewController: UICollectionViewController {
    
    private let games = GamesPreset.allCases
    private let webMenager = WebMenager.shared
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        games.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let game = games[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard let cell = cell as? GamePreviewCell else { return UICollectionViewCell() }
        
        cell.title.text = game.title
        webMenager.fetchIcon(game.icon) { result in
            switch result {
                case .success(let success):
                    print("complite")
                    cell.icon.image = UIImage(data: success)
                case .failure(let failure):
                    print("Icon  - \(failure)")
            }
        }
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let game = games[indexPath.item]
        
        performSegue(withIdentifier: "news", sender: game)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //guard let indexPaf = sender as? IndexPath else { return }
        guard let game = sender as? GamesPreset else { return }
        let newsVC = segue.destination as? NewsViewController
        newsVC?.fetchNews(game.id)
        newsVC?.fetchIcon(game.icon)
        
    }
    
}
