//
//  Utils.swift
//  korea_social_login
//
//  Created by Channoori Park on 11/27/23.
//

import Foundation

class Utils {
    public static func dateToString(format: String? = "yyyy-MM-dd HH:mm:ss", date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
