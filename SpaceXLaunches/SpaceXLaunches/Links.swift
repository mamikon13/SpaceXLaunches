//
//  Links.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 17/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import UIKit


struct Links {
    let missionPatch: URL?
    
    let redditMedia: URL?
    let articleLink: URL?
    let wikipedia: URL?
    let videoLink: URL?
}



extension Links: Decodable {
    private enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch_small"
        
        case redditMedia = "reddit_media"
        case articleLink = "article_link"
        case wikipedia = "wikipedia"
        case videoLink = "video_link"
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.missionPatch = try? container.decode(URL.self, forKey: .missionPatch)
        self.redditMedia = try? container.decode(URL.self, forKey: .redditMedia)
        self.articleLink = try? container.decode(URL.self, forKey: .articleLink)
        self.wikipedia = try? container.decode(URL.self, forKey: .wikipedia)
        self.videoLink = try? container.decode(URL.self, forKey: .videoLink)
    }
}
