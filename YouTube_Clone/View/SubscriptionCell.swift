//
//  SubscriptionCell.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/11/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

class SubscriptionCell : FeedCell{
    override func fetchVideos() {
       APIService.shared.fetchVideos(withType: "subscriptions") { (videos) in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

