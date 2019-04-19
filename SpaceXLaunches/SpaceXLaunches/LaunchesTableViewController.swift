//
//  LaunchesTableViewController.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 16/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import UIKit

class LaunchesTableViewController: UITableViewController {
    
//    var model: Model!
    var launches: [Launch]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        model.loadData()
//        let launches = self.launches
        self.launches = Model.sharedInstance.launches
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("dataRefreshed"), object: nil, queue: nil) { (notification) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name?(NSNotification.Name(rawValue: "errorWhileJSONLoading")), object: nil, queue: nil) { (notification) in
            
            let errorDesc = notification.userInfo?["ErrorDescription"]
            print(errorDesc!)
            
            
            var startIndex = errorDesc.debugDescription.firstIndex(of: "\"")
            startIndex = errorDesc.debugDescription.index(startIndex!, offsetBy: 1)
            let lastIndex = errorDesc.debugDescription.lastIndex(of: "\"")
            let errorString = String(errorDesc.debugDescription[startIndex!..<lastIndex!])
            
            
            let errorAlert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertController.Style.alert)
            
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            errorAlert.addAction(alertAction)
            
            DispatchQueue.main.async {
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.launches.count
//        return 4
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! LaunchCell

        let launchForCell = self.launches[indexPath.row]
        cell.initCell(launch: launchForCell)
//
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
