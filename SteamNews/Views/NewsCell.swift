//
//  NewsViewCell.swift
//  SteamNews
//
//  Created by Winky51 on 23.09.2024.
//

import UIKit

final class NewsCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    func config(_ data: Newsitems) {
        let date = Date(timeIntervalSince1970: data.date)
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .long
        dateFormater.timeStyle = .none
        titleLabel.text = data.title
        authorLabel.text = "Author: \(data.author)"
        dateLabel.text = dateFormater.string(from: date)
    }
}
