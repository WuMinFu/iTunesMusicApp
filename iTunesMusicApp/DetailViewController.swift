//
//  DetailViewController.swift
//  iTunesMusicApp
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    var artworkUrl100: URL?
    var artist: String?
    var collection: String?
    var trackName: String?
    var previewUrl: URL?
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage(url: artworkUrl100!) { (image) in
            DispatchQueue.main.async {
                self.trackImageView.image = image
            }
        }
        artistLabel.text = "演奏者：\(artist!)"
        trackNameLabel.text = "歌曲：\(trackName!)"
        collectionLabel.text = "專輯：\(collection!)"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func previewSongButton(_ sender: Any) {
        let player = AVPlayer(url: previewUrl!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getImage(url: URL, completion: @escaping (UIImage?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
}
