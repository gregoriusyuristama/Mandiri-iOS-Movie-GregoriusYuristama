//
//  UserReviewTableViewCell.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/9/24.
//

import UIKit

class UserReviewTableViewCell: UITableViewCell {
    
    static let identifier = "UserReviewTableViewCell"
    
    @IBOutlet weak var userReviewLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    static func nib() -> UINib {
        .init(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(_ userReview: UserReviewsModel) {
        self.usernameLabel.text = userReview.author
        self.userReviewLabel.text = userReview.content
    }
    
}
