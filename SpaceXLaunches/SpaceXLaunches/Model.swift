//
//  Model.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 16/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import UIKit
import Foundation


protocol ModelDelegate: class {
    func didReceived(error: Error?)
}



class Model {
    
    weak var delegate: ModelDelegate?
    
    var launches: [Launch] = []
    private let url = URL(string: "https://api.spacexdata.com/v3/launches")
    
    
    func loadData(completionHandler: @escaping ([Launch]) -> Void) {
        
        let task = URLSession.shared.dataTask(with: self.url!) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            guard let error = error else {
                print("Данные загружены")
                self.launches = self.parsingJSON(data!) //  Parse data in success case
                
                completionHandler(self.launches)
                return
            }
            
            print("Error within 'loadData': " + error.localizedDescription)
            self.delegate?.didReceived(error: error)
        }
        
        task.resume()
    }
    
    
    private func parsingJSON(_ data: Data) -> [Launch] {
        
        var launches: [Launch] = []
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            launches = try decoder.decode([Launch].self, from: data)
        } catch {
            print("Error while parsing JSON within 'loadData': " + error.localizedDescription)
            delegate?.didReceived(error: error)
        }
        
        print("Данные обновлены")
        return launches
    }
    
}
