//
//  WebViewController.swift
//  SteamNews
//
//  Created by Winky51 on 08.10.2024.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!


    func presentNews(_ url: URL) {
        DispatchQueue.global().async{
            let newsRequest = URLRequest(url: url)
            DispatchQueue.main.async {
                self.webView.load(newsRequest)
            }
        }
        
    }
}
