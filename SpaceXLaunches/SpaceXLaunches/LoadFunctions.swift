//
//  loadImage.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 28/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import UIKit
import Foundation


class LoadFunctions {
    
    func downloadImage(from url: URL?, completion: @escaping (UIImage?) -> ()) -> URLSessionTask? {
        guard let url = url else {
            completion(UIImage(named: "empty_patch"))
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let error = error else {
                guard let image = UIImage(data: data!) else {
                    completion(nil)
                    return
                }
                completion(image)
                return
            }
            print("Error within 'loadImage': " + error.localizedDescription)
        }
        
        task.resume()
        return task
    }
    
}
