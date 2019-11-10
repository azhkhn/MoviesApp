//
//  Movie.swift
//  Movies
//
//  Created by Omar Thamri on 10/11/2019.
//  Copyright © 2019 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit

class Movie: NSObject {
    
    var name: String?
    var imageName: String?
    
    init(name: String?,imageName: String?) {
        self.name = name
        self.imageName = imageName
    }
    
}
