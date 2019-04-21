//
//  Model.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 16/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import Foundation


protocol ModelDelegate: class {
    func didReceived(error: Error?)
}



class Model {
    
    weak var delegate: ModelDelegate?
    
    private var launches: [Launch] = []
    private let url = URL(string: "https://api.spacexdata.com/v3/launches")
    
    
    func loadData(completionHandler: @escaping (_ launches: [Launch]) -> Void) {
        
        let task = URLSession.shared.dataTask(with: self.url!) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error == nil {
                print("Данные загружены")
                self.parsingJSON(data!) //  Parse data in success case
                
                completionHandler(self.launches)
                
            } else {
                print("Error within 'loadData': " + error!.localizedDescription)
                self.delegate?.didReceived(error: error)
            }
        }
        
        task.resume()
    }
    
    
    private func parsingJSON(_ data: Data) {
        
        self.launches = []
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            launches = try decoder.decode([Launch].self, from: data)
        } catch {
            print("Error while parsing JSON within 'loadData': " + error.localizedDescription)
            delegate?.didReceived(error: error)
        }
        
        print("Данные обновлены")
    }
    
}
