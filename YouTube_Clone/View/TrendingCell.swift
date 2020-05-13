//
//  TrendingCell.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/11/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

class TrendingCell : FeedCell{
    override func fetchVideos() {
       APIService.shared.fetchVideos(withType: "trending") { (videos) in
        self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
