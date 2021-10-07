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

    }
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

}
