//
//  LaunchesTableViewController.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 16/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import UIKit


class LaunchesTableViewController: UITableViewController {
    
    private var model: Model?
    
    private var activityIndicator = UIActivityIndicatorView(style: .gray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        setupActivityIndicator()
        setupRefreshControl()
        
        setupModel()
        loadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender:  Any?) {
        guard let selectedCellIndexRow = tableView.indexPathForSelectedRow?.row else { return }
        (segue.destination as? LaunchViewController)?.launch = model?.launches[selectedCellIndexRow]
    }
    
}



private extension LaunchesTableViewController {
    
    func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    
    func setupModel() {
        model = Model()
        model?.delegate = self
    }
    
    
    func loadData() {
        model?.loadData() { [weak self] (_) in
            guard let self = self else { return }
            
            self.sortLaunchesByDate()
            
            DispatchQueue.main.async {
                self.stopRefreshingUI()
                self.tableView.reloadData()
            }
        }
    }
    
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        
        refreshControl?.addTarget(self,
                                  action: #selector(handleRefresh),
                                  for: .valueChanged)
        refreshControl?.tintColor = UIColor.black
        
        guard let unwrappedRefreshControl = refreshControl else { return }
        view.addSubview(unwrappedRefreshControl)
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        loadData()
    }
    
    
    func stopRefreshingUI() {
        refreshControl?.endRefreshing()
        activityIndicator.stopAnimating()
    }
    
    
    func sortLaunchesByDate() {
        guard let model = model else { return }
        
        let sortedLaunches = model.launches.sorted {
            $0.launchDate > $1.launchDate   // firstly newest launches
        }
        
        model.launches = sortedLaunches
    }
    
}


// MARK: - Table view data source

extension LaunchesTableViewController: ModelDelegate {
    
    func didReceived(error: Error?) {
        guard let unwrappedError = error else { return }
        
        let description = unwrappedError.localizedDescription
        var startIndex = description.debugDescription.firstIndex(of: "\"")
        startIndex = description.debugDescription.index(startIndex!, offsetBy: 1)
        let lastIndex = description.debugDescription.lastIndex(of: "\"")
        
        let errorString = String(description.debugDescription[startIndex!..<lastIndex!])
        
        
        let errorAlert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertController.Style.alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        errorAlert.addAction(alertAction)
        
        DispatchQueue.main.async {
            self.present(errorAlert, animated: true, completion: { self.stopRefreshingUI() })
        }
    }
    
}


// MARK: - Table view data source

extension LaunchesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.launches.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? LaunchCell
        
        let launchForCell = self.model?.launches[indexPath.row]
        guard let unwrappedLaunchForCell = launchForCell else { return UITableViewCell() }
        
        cell?.setupCell(launch: unwrappedLaunchForCell)
        guard let unwrappedCell = cell else { return UITableViewCell() }
        
        return unwrappedCell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

