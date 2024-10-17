//
//  StartViewController.swift
//  SteamNews
//
//  Created by Winky51 on 08.10.2024.
//

import UIKit


final class StartViewController: UICollectionViewController {
    
    private let games = GamesPreset.allCases
    private let networkManager = NetworkManager.shared
    
    
    // MARK: UICollectionViewDataSource
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        games.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let game = games[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard let cell = cell as? GamePreviewCell else { return UICollectionViewCell() }
        
        cell.title.text = game.title
        cell.activityIndicator.startAnimating()
        networkManager.fetchData(game.id) { result in
            switch result {
                case .success(let image):
                    cell.icon.image = UIImage(data: image)
                    cell.activityIndicator.stopAnimating()
                    cell.title.isHidden.toggle()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let game = games[indexPath.item]
        
        performSegue(withIdentifier: "news", sender: game)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let game = sender as? GamesPreset else { return }
        let newsVC = segue.destination as? NewsViewController
        
        newsVC?.fetchNews(game.id)
        newsVC?.fetchIcon(game.id)
        
    }
    
}
