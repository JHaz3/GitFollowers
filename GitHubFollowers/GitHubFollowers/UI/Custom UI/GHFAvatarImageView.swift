//
//  GHFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Jake Haslam on 10/8/21.
//

import UIKit

class GHFAvatarImageView: UIImageView {
    
    let cache = NetworkController.shared.cache
    let avatarPlaceHolderImage = UIImage(named: "avatar-placeholder" )
    
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
    
    func fetchAvatarImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let self = self else { return }
            if error != nil { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
            
        } .resume()
        
    }
    
}// End of Class
