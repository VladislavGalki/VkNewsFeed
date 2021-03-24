//
//  NewsFeedCell.swift
//  VkNewsFeed
//
//  Created by Владислав Галкин on 23.03.2021.
//

import UIKit

protocol NewsFeedCellViewModelProtocol {
    var profile: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    
}

class NewsFeedCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    
    static let cellId = "NewsFeedCell"
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(viewModel: NewsFeedCellViewModelProtocol) {
        profileImage.setImage(from: viewModel.profile)
        nameLabel.text = viewModel.name
        dataLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
    }
}
