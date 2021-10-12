//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Jake Haslam on 10/9/21.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
