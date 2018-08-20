//
//  ViewController.swift
//  iTunesMusicApp
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class iTunesTableViewController: UIViewController ,UITableViewDataSource{
    
    struct Cell {
        static let songCell = "songCell"
    }
    
    var songs = [Song]()
    var artistStr : String?
    
    @IBOutlet weak var artistTextField: UITextField!
    
    @IBOutlet weak var itunesTableVIew: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.songCell, for: indexPath) as? iTunesTableViewCell else {
            return UITableViewCell()
        }
        cell.artistLabel.text = "演奏者："+songs[indexPath.row].artistName
        cell.trackLabel.text = "歌曲："+songs[indexPath.row].trackName
        
        getImage(url: songs[indexPath.row].artworkUrl100) { (image) in
            DispatchQueue.main.async {
                cell.trackImageView.image = image
            }
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "https://itunes.apple.com/search?term=麋先生&media=music".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlStr!)
        let task = URLSession.shared.dataTask(with: url!) { (data, res, err) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = data, let songResults = try? decoder.decode(iTunesMusic.self, from: data) {
                
                self.songs = songResults.results
                DispatchQueue.main.async {
                    self.itunesTableVIew.reloadData()
                }
                
            } else {
                print("error")
            }
        }
        task.resume()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func searchButton(_ sender: Any) {
        guard let artistTextField = artistTextField.text else{
            return
        }
        artistStr = artistTextField
        let urlStr = "https://itunes.apple.com/search?term=\(artistStr!)&media=music".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlStr!)
        let task = URLSession.shared.dataTask(with: url!) { (data, res, err) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = data, let songResults = try? decoder.decode(iTunesMusic.self, from: data) {
                
                self.songs = songResults.results
                DispatchQueue.main.async {
                    self.itunesTableVIew.reloadData()
                }
                
            } else {
                print("error")
            }
        }
        task.resume()
    }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? DetailViewController
        let indexPath = itunesTableVIew.indexPathForSelectedRow
        controller?.artworkUrl100 = songs[(indexPath?.row)!].artworkUrl100
        controller?.artist = songs[(indexPath?.row)!].artistName
        controller?.trackName = songs[(indexPath?.row)!].trackName
        controller?.collection = songs[(indexPath?.row)!].collectionName
        controller?.previewUrl = songs[(indexPath?.row)!].previewUrl
        
    }
}

