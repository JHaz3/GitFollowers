//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Jake Haslam on 10/7/21.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GHFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentDefaultError() {
        let alertVC = GHFAlertViewController(title: "Something Went Wrong",
                                message: "We were unable to complete your task at this time. Please try again.",
                                buttonTitle: "Ok")
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
