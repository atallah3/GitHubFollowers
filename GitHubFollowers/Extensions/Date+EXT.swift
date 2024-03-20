//
//  Date+EXT.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 03/03/2024.
//

import Foundation


extension Date {
    
    func convertToMonthYearFormat()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
