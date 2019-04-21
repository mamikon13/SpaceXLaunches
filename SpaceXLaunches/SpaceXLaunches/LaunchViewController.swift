//
//  LaunchViewController.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 21/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var launch: Launch?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var launchSiteLabel: UILabel!
    
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketTypeLabel: UILabel!
    
    @IBOutlet weak var missionPatch: UIImageView!
    
    @IBAction func videoPushedLink(_ sender: Any) {
        openURL(launch, url: launch?.links.videoLink)
    }
    
    @IBAction func wikipediaPushedLink(_ sender: Any) {
        openURL(launch, url: launch?.links.wikipedia)
    }
    
    @IBAction func articlePushedLink(_ sender: Any) {
        openURL(launch, url: launch?.links.articleLink)
    }
    
    @IBAction func redditPushedLink(_ sender: Any) {
        openURL(launch, url: launch?.links.redditMedia)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
        
        missionNameLabel.numberOfLines = 0
        launchSiteLabel.numberOfLines = 0
        
        guard let launch = launch else { return }
        setupLaunchProperties(launch)
    }
    
}



private extension LaunchViewController {
    
    func setupLaunchProperties(_ launch: Launch) {
        
        missionNameLabel.text = launch.missionName
        launchDateLabel.text = CustomizedDateFormatter().fromDateToString(date: launch.launchDate)
        
        successLabel.text = {
            guard let success = launch.success else { return "Scheduled" }
            return success ? "Success" : "Not success"
        } ()
        
        detailsTextView.text = launch.details
        launchSiteLabel.text = launch.launchSite
        
        rocketNameLabel.text = launch.rocket.rocketName
        rocketTypeLabel.text = launch.rocket.rocketType
        
        LaunchCell().downloadImage(from: launch.links.missionPatch) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.missionPatch.image = image }
        }
    }
    
    
    func openURL(_ launch: Launch?, url: URL?) {
        guard
            let _ = launch,
            let url = url
            else { return }
        
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
}
