//
//  VideoCategoryVC.swift
//  smallVideo
//
//  Created by zky on 2017/12/7.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class VideoCategoryVC: BaseVC , UITableViewDataSource, UITableViewDelegate {

    
    var player : BMPlayer?
    var playCell : VideoCategoryCell?
    var cellCurrentIndex : Int?
    var category : String?
    var vcIndex : Int?
    
    
    
    var dataArr: NSArray = NSArray() {
        didSet{
            tableView.reloadData()
        }
        
    }
    
    lazy var tableView : UITableView = {
        let tableView  = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.view.frame.size.height), style: .plain)
        return tableView;
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VideoCategoryCell.self, forCellReuseIdentifier: "VideoCategoryCell")
        tableView.tableFooterView = UIView()
        view .addSubview(tableView)
        loadDataArr("", vcIndex!)
    }
    
    
    
    func loadDataArr(_ category : String, _ index : Int) {
        let params = ["index" : index] as [String : AnyObject]
        HttpTool.shareInstance.request_queryPdList(params: params, success: { (result) in
            
            self.dataArr = VideoListModel.toVidelListModel(dataArr: result as! NSArray) as NSArray
            
        }) { (error) in
            
        }
    }
    
    // MARK: - tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArr.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCategoryCell", for: indexPath) as! VideoCategoryCell
        cell.listModel = dataArr[indexPath.row] as! VideoListModel
        cell.delegate = self as VideoCategoryCellDelegate
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - VideoCategoryCellDelegate
extension VideoCategoryVC : VideoCategoryCellDelegate {
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
extension VideoCategoryVC: BMPlayerDelegate {
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
