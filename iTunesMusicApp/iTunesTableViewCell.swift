//
//  iTunesTableViewCell.swift
//  iTunesMusicApp
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class iTunesTableViewCell: UITableViewCell {

    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
