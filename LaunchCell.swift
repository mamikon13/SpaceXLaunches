//
//  LaunchCell.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 19/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import UIKit


class LaunchCell: UITableViewCell {
    
    var task: URLSessionTask?
    
    @IBOutlet weak var missionName: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var success: UILabel!
    @IBOutlet weak var successIndicator: UIImageView!
    @IBOutlet weak var missionPatch: UIImageView!
    
    private let successIcon: UIImage? = {
        return UIImage(named: "success")
    }()
    
    private let notSuccessIcon: UIImage? = {
        return UIImage(named: "not success")
    }()
    
    private let scheduledIcon: UIImage? = {
        return UIImage(named: "scheduled")
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        missionName.numberOfLines = 0
    }
    
    
    func setupCell(launch: Launch) {
        
        missionName.text = launch.missionName
        launchDate.text = CustomizedDateFormatter().fromDateToString(date: launch.launchDate)
        
        success.text = {
            guard let success = launch.success else { return "Scheduled" }
            return success ? "Success" : "Not success"
        } ()
        
        successIndicator.image = {
            guard let success = launch.success else { return self.scheduledIcon }
            return success ? self.successIcon : self.notSuccessIcon
        } ()
        
        task = LoadFunctions().downloadImage(from: launch.links.missionPatch) { [missionPatch] image in
            DispatchQueue.main.async { missionPatch?.image = image }
        }
    }
    
    
    override func prepareForReuse() {
        missionPatch.image = nil
        task?.cancel()
        super.prepareForReuse()
    }
    
}
