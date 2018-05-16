//
//  VideoCategoryView.swift
//  SmallVideo
//
//  Created by zky on 2017/9/1.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit


class VideoCategoryView: UITableView ,UITableViewDataSource, UITableViewDelegate{

    var player : BMPlayer?
    var playCell : VideoCategoryCell?
    var cellCurrentIndex : Int?
    
    
    var dataArr: NSArray = NSArray() {
        didSet{
            reloadData()
        }
        
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        register(VideoCategoryCell.self, forCellReuseIdentifier: "VideoCategoryCell")
        tableFooterView = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadDataArr(_ category : String, _ index : Int) {

//        HttpTools.requestData(.get, URLString: "queryPdList?type=\(index)&deviceId=1&offset=0") { (result) in
//        print("\(category)--\(result)")
//            self.dataArr = VideoListModel.toVidelListModel(dataArr: result as! NSArray) as NSArray
//        }
    }
    
    // MARK: - tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArr.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCategoryCell", for: indexPath) as! VideoCategoryCell
        cell.listModel = dataArr[indexPath.row] as! VideoListModel
        cell.delegate = self
        cell.cellIndex = indexPath.row
        cell.headTouched = {
            print("hahhaaaaaaaaaaa")
        }
        return cell
    }
    
    // MARK: - tableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return VideoCategoryCell.getVideoCategoryCellHeight()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cellCurrentIndex == indexPath.row {
            player?.pause()
            player?.removeFromSuperview()
            player?.prepareToDealloc()
            player = nil
//            print(player)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
    
}


// MARK: - VideoCategoryCellDelegate
extension VideoCategoryView : VideoCategoryCellDelegate {
    func touchedPlayImageButton(cell: VideoCategoryCell, cellIndex : Int) {
        
        if cellCurrentIndex != cellIndex {
            player?.pause()
            player?.removeFromSuperview()
            player = nil
        }
        
        cellCurrentIndex = cellIndex
        playCell = cell
        BMPlayerConf.allowLog = false
        BMPlayerConf.shouldAutoPlay = true
        BMPlayerConf.tintColor = UIColor.white
        BMPlayerConf.topBarShowInCase = .horizantalOnly
        BMPlayerConf.loaderType  = NVActivityIndicatorType.ballRotateChase
        player = BMPlayer.shared
        player?.delegate = self
        player?.frame = cell.playImageButton.bounds
        cell.addSubview(player!)
        player?.backBlock = { (unowned : Bool) in
            print("点击了返回按钮")
        }
        let listModel = self.dataArr[cellIndex] as! VideoListModel;
        let asset = BMPlayerResource(url: URL(string: listModel.url1)!, name: listModel.title)
        player?.setVideo(resource: asset)
    }
}

// MARK:- BMPlayerDelegate
extension VideoCategoryView: BMPlayerDelegate {
    // Call back when playing state changed, use to detect is playing or not
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        print("| BMPlayerDelegate | playerIsPlaying | playing - \(playing)")
    }
    
    // Call back when playing state changed, use to detect specefic state like buffering, bufferfinished
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        print("| BMPlayerDelegate | playerStateDidChange | state - \(state)")
    }
    
    // Call back when play time change
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        //        print("| BMPlayerDelegate | playTimeDidChange | \(currentTime) of \(totalTime)")
    }
    
    // Call back when the video loaded duration changed
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        //        print("| BMPlayerDelegate | loadedTimeDidChange | \(loadedDuration) of \(totalDuration)")
    }
}

