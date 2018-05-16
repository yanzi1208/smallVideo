//
//  PublicVideoVC.swift
//  smallVideo
//
//  Created by zky on 2018/1/21.
//  Copyright © 2018年 zky. All rights reserved.
//

import UIKit
import AssetsLibrary

class PublicVideoVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource {

    private let reusedId : String = "PublicVideoCell"
    fileprivate var assetsLibrary = ALAssetsLibrary()
    fileprivate let albumsGroupArray = NSMutableArray()
    let videoArray = NSMutableArray()
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        
        let rect = self.view.bounds;
        let collection = UICollectionView.init(frame: rect , collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(PublicVideoCell.self, forCellWithReuseIdentifier: self.reusedId)
        collection.backgroundColor = UIColor.white
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verityAuthorization()
        view.addSubview(collectionView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusedId, for: indexPath) as! PublicVideoCell
        let asset = videoArray[indexPath.item] as! ALAsset
        let image = UIImage(cgImage: asset.thumbnail().takeUnretainedValue())
        cell.videoImage.image = image
        cell.videoImage.backgroundColor = UIColor.red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let asset = videoArray[indexPath.item] as! ALAsset
        present(PublicEditVC.init(asset.defaultRepresentation().url()! as NSURL), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PublicVideoVC {
    /** 验证授权信息 */
    func verityAuthorization() {
        var tipTextWhenNoPhotosAuthorization  = ""
        let authorizationStatus = ALAssetsLibrary.authorizationStatus()
        if authorizationStatus == .restricted || authorizationStatus == .denied {
            let mainInfoDictionary = Bundle.main.infoDictionary! as NSDictionary
            let appName = mainInfoDictionary.object(forKey: "CFBundleDisplayName") as! String
            tipTextWhenNoPhotosAuthorization = "请在设备的\"设置-隐私-照片\"选项中，允许\(appName)访问你的手机相册"
            
            let alert = UIAlertView.init(title: "提示", message: tipTextWhenNoPhotosAuthorization, delegate: nil, cancelButtonTitle: "好的")
            alert.show()
        }else {
            getAlbumsGroup()
        }
    }
    
    func getAlbumsGroup() {
        assetsLibrary = ALAssetsLibrary()
        assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupAll, usingBlock: { (group, stop) in
            
            if let group1 = group {
                group1.setAssetsFilter(ALAssetsFilter.allVideos())
                if group1.numberOfAssets() > 0 {
                    self.albumsGroupArray.add(group1)
                }
            }else {
                if self.albumsGroupArray.count > 0 {
                    self.emnumeVideoList()
                }
            }
        }) { (error) in
            
        }
    }
    
    func emnumeVideoList() {
        for (_, assetsGroup) in albumsGroupArray.enumerated() {
            (assetsGroup as! ALAssetsGroup).enumerateAssets({ (result, index, stop) in
                if let result1 = result {
                    self.videoArray.add(result1)
                }
            })
        }
        collectionView.reloadData()
    }
}

