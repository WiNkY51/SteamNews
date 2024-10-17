//
//  WebViewController.swift
//  SteamNews
//
//  Created by Winky51 on 08.10.2024.
//

import UIKit

final class ContentViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var titleText: String!
    var contentText: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleText
        contentLabel.text = contentText
    }
}
