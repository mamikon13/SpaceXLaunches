//
//  Launch.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 17/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import UIKit


struct Launch {
    let flightNumber: Int
    let missionName: String
    let launchDate: Date
    let success: Bool
    
    let links: Links
    let rocket: Rocket
    
    let details: String?
    let launchSite: String?
}



extension Launch: Decodable {
     private enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchDate = "launch_date_unix"
        case success = "launch_success"
        
        case links = "links"
        case rocket = "rocket"
        
        case details = "details"
        case site = "launch_site"
        
        enum SiteCodingKeys: String, CodingKey {
            case launchSite = "site_name_long"
        }
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        self.missionName = try container.decode(String.self, forKey: .missionName)
        self.launchDate = try container.decode(Date.self, forKey: .launchDate)
        self.success = try container.decode(Bool.self, forKey: .success)
        
        self.links = try container.decode(Links.self, forKey: .links)
        self.rocket = try container.decode(Rocket.self, forKey: .rocket)
        
        self.details = try container.decode(String.self, forKey: .details)
        
        let launchSiteContainer = try container.nestedContainer(keyedBy: CodingKeys.SiteCodingKeys.self, forKey: .site)
        self.launchSite = try launchSiteContainer.decode(String.self, forKey: .launchSite)
    }
}
