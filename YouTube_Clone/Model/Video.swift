//
//  Video.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/7/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

struct Video: Decodable {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: Int?
    var uploadDate: Date?
    
    var channel: Channel?
    
}

struct Channel: Decodable {
    var name: String?
    var profileImageName: String?
}
