//
//  PostTableViewCell.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 23.03.2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    func configurePostCell (_ post: Post) {
        self.postTitleLabel.text = post.title
        self.postBodyLabel.text = post.body
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
