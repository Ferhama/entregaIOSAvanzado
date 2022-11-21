//
//  CollectionViewCell.swift
//  MusasDelSwing
//
//  Created by Fernando Haro Martínez on 19/11/22.
//

import UIKit
import WebKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var webPlayerView: UIView!
    
    
    var webPlayer:WKWebView!
    //var miyouTubeUrl: String = "https://www.youtube.com/embed/YE7VzlLtp-4?playsinline=1"
    var videoID: String = "YE7VzlLtp-4"
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
         
            self.isUserInteractionEnabled = true
           // initialize what is needed
        let webConfiguration = WKWebViewConfiguration()
                webConfiguration.allowsInlineMediaPlayback = true
                
                DispatchQueue.main.async {
                    self.webPlayer = WKWebView(frame: self.webPlayerView.bounds, configuration: webConfiguration)
                    self.webPlayerView.addSubview(self.webPlayer)
                    
                    print("print Llega: " + self.videoID)
                    
                    guard let videoURL = URL(string: "https://www.youtube.com/embed/\(self.videoID)/?playsinline=1") else { return }
                    let request = URLRequest(url: videoURL)
                    self.webPlayer.load(request)
                }
        }
}
    
 
