//
//  NewsViewController.swift
//  SteamNews
//
//  Created by Winky51 on 23.09.2024.
//

import UIKit

final class NewsViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? NewsViewCell else { return UITableViewCell() }
        
        
        return cell
    }
   
    
}
