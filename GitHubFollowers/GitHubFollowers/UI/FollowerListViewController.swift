//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Jake Haslam on 10/7/21.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    // MARK: - Properties
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
        NetworkController.shared.getFollowers(for: username, page: 1) { (result) in
            
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self.presentGHFAlertOnMainThread(title: "Mission Failed...", message: error.localizedDescription, buttonTitle: "Ok")
                
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
}
