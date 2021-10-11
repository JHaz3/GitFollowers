//
//  GHFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Jake Haslam on 10/8/21.
//

import UIKit

class GHFAvatarImageView: UIImageView {
    
    let cache = NetworkController.shared.cache
    let avatarPlaceHolderImage = Images.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = avatarPlaceHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}// End of Class
