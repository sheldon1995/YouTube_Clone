//
//  ViewController.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/5/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let homeCellIdentifier = "HomeCell"

let feedCellId = "FeedCell"

let trendingCellId = "TrendingCellId"

let subscriptionCellId = "subscriptionCellId"
class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    
    // The code inside the lazy var will be exected once while the varable is nil
    lazy var settingsLauncher : SettingLauncher = {
        let launcher = SettingLauncher()
        launcher.homeVC = self
        return launcher
    }()
    
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.homeVC = self
        return mb
    }()
 
    
    override var prefersStatusBarHidden: Bool {
        setNeedsStatusBarAppearanceUpdate()
      return true
    }
    
    lazy var titleLabel : UILabel = {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        label.text = "  Home"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 21,weight: .semibold)
        return label
    }()

    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.titleView = titleLabel
        
        
        navigationController?.navigationBar.isTranslucent = false
        
        setUpCollectionView()
        
        setUpMenuBar()
        
        setUpNavBar()
        
        
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    //MARK: - CollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        var identifier : String = feedCellId
        
        if indexPath.item == 0{
            identifier = feedCellId
           
        }
        else if indexPath.item == 1{
             identifier = trendingCellId
         
        }
        else if indexPath.item == 2{
             identifier = subscriptionCellId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 84)
    }
    
    
    //MARK: - Help Functions
    
    // Set up collection view
    private func setUpCollectionView(){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        
        
        collectionView.contentInset = UIEdgeInsets(top: 50,left: 0,bottom: 0,right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50,left: 0,bottom: 0,right: 0)
        
    
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: feedCellId)
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
    }
    
    // Set up memu bar
    private func setUpMenuBar(){
        
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor = .red
        view.addSubview(redView)
        redView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
        
        view.addSubview(menuBar)
        menuBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,width: self.collectionView.frame.width,height: 50)
        
    }
    
    // Set up navigation bar
    private func setUpNavBar(){
        
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButtonImage = UIImage(named: "more_button")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let moreButtonItem = UIBarButtonItem(image: moreButtonImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButtonItem,searchBarButtonItem]
    }
    
    
    @objc func handleSearch(){
        
    }
    
    
    func scolltoMenIndex(menuIndex : Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    @objc func handleMore(){
        settingsLauncher.showSettings()
        
    }
    
    
    func showControllerForSetting(withSetting settingTitle : String){
        
        let dummingSettingVC = UIViewController()
        dummingSettingVC.navigationItem.title = settingTitle
        dummingSettingVC.view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.pushViewController(dummingSettingVC, animated: true)
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
        
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        titleLabel.text = "  " + menuBar.imageNames[indexPath.row].capitalized
    }
}


