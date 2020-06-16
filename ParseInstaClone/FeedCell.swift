//
//  FeedCell.swift
//  ParseInstaClone
//
//  Created by Sefa Çelik on 31.05.2020.
//  Copyright © 2020 Sefa Celik. All rights reserved.
//
import UIKit
import Parse

class FeedCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postCommentLabel: UITextView!
    @IBOutlet weak var postUuidLabel: UILabel!
    
    var playerIDArray = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        postUuidLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeClicked(_ sender: Any) {
        
    }
    
    @IBAction func commentClicked(_ sender: Any) {
        
    }
    
}
