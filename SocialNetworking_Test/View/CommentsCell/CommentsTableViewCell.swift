//
//  CommentsTableViewCell.swift
//  SocialNetworking_Test
//
//  Created by Юрий Куринной on 27.03.2023.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
   
    @IBOutlet weak var commentLabel: UILabel!
    
    func configureCommentCell(_ comment: Comment) {
        self.commentLabel.text = comment.body
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = .systemPink
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
