//
//  Model.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 16/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import Foundation


class Model {
    
    static let sharedInstance = Model()
    
    var launches: [Launch] = []
    let url = URL(string: "https://api.spacexdata.com/v3/launches?limit=4")
//    let url = URL(string: "https://api.spacexdata.com/v3/launches/5") // error while loading 5th launch
    
    
    func loadData() {
        
        let task = URLSession.shared.dataTask(with: self.url!) { (data, responce, error) in
            var errorLoading: String?
            
            if error == nil {
                //  attempt to save loaded "data" to file by "urlForSave"
                do {
                    try self.parsingJSON(data!) //  Parse data in success case
                    print("Данные загружены")
                } catch {
                    print("Error when save data within 'loadData': " + error.localizedDescription)
                    
                    errorLoading = error.localizedDescription
                }
            } else {
                print("Error within 'loadData': " + error!.localizedDescription)
                
                errorLoading = error!.localizedDescription
            }
            
            //  if data wasn't loaded
            if let errorLoading = errorLoading {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "errorWhileDJSONLoading"), object: self, userInfo: ["ErrorDescription":errorLoading])
            }
            
            if error != nil {
                print("Error: \(error!.localizedDescription)")
            }
        }
        print(self.launches)    // temporary
        task.resume()
    }
    
    
    func parsingJSON(_ data: Data) throws -> Void {
        
        self.launches = []
        
        let decoder = JSONDecoder()
        //decoder.dateDecodingStrategy = .formatted(DateFormatter.ISO8601)
        
        self.launches = try decoder.decode([Launch].self, from: data)
//        let launch = try? decoder.decode(Launch.self, from: data)
        
        print("Данные обновлены")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed"), object: self)
    }
}
