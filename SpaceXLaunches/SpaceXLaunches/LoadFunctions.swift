//
//  loadImage.swift
//  SpaceXLaunches
//
//  Created by Mamikon Nikogosyan on 28/04/2019.
//  Copyright © 2019 Mamikon Nikogosyan. All rights reserved.
//

import  UIKit
import Foundation


class LoadFunctions {
    
    func downloadImage(from url: URL?, completion: @escaping (UIImage?) -> ()) {
        guard let url = url else {
            completion(UIImage(named: "empty_patch"))
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            guard
                let imageData = try? Data(contentsOf: url),
                let image = UIImage(data: imageData)
                else {
                    completion(nil)
                    return
            }
            completion(image)
        }
    }
    
}
