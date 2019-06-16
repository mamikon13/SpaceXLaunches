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
