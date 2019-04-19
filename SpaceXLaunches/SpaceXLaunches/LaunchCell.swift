//
//  LaunchCell.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 19/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import UIKit

class LaunchCell: UITableViewCell {
    @IBOutlet weak var launchName: UILabel!
    
    func initCell(launch: Launch) {
        launchName.text = launch.missionName
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
