//
//  CustomizedDateFormatter.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 20/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import Foundation


class CustomizedDateFormatter: DateFormatter {
    
    private let dateFormatter = DateFormatter()
    
    
    func fromStringToDate(date stringDate: String, dateFormat: String = "dd.MM.yyyy") -> Date? {
        self.dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: stringDate)
    }
    
    
    func fromDateToString(date: Date?, dateFormat: String = "dd.MM.yyyy") -> String? {
        self.dateFormatter.dateFormat = dateFormat
        
        guard let date = date else {
            return ""
        }
        
        return dateFormatter.string(from: date)
    }
    
}


//extension DateFormatter {
//
//    static let fullISO8601: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
//        formatter.calendar = Calendar(identifier: .iso8601)
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//
//        return formatter
//    }()
//}
