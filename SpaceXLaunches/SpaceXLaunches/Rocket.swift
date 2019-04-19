//
//  Rocket.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 17/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import UIKit


struct Rocket {
    let rocketName: String?
    let rocketType: String?
}



extension Rocket: Decodable {
    private enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.rocketName = try container.decode(String.self, forKey: .rocketName)
        self.rocketType = try container.decode(String.self, forKey: .rocketType)
    }
}
