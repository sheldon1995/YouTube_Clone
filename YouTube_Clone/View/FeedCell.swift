//
//  FeedCell.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/10/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: - Properties
    var videos = [Video]()
    let cellId = "VideoCell"
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setUpViews()
        
        fetchVideos()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UICollection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width
        let height = (width - 16 - 16) * 9 / 16
        return CGSize(width: self.frame.width, height: height + 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
    
    
    //MARK: - Help Functions
    func fetchVideos() {
        APIService.shared.fetchVideos(withType: "home") { (videos) in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func setUpViews(){
        
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    
    
    
}
