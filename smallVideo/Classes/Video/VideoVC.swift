//
//  VideoVC.swift
//  SmallVideo
//
//  Created by zky on 2017/8/24.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class VideoVC: BaseVC {
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(imageNamed("searchicon_search_20x20_"), for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        let topStatusView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
        topStatusView.backgroundColor =  rgb(r: 52, g: 53, b: 57)
        view.addSubview(topStatusView)
        
        /// 设置数据源
        let titles = ["推荐", "热点", "知识书籍", " 为人处世", "健康养生", "体育", "游戏", "健身"]
        var childVCs = [VideoCategoryVC]()
        for i in 0..<titles.count {
            let vc = VideoCategoryVC()
            vc.vcIndex = i;
            childVCs.append(vc)
        }
        /// 设置外观
        let appreance = YLPageScrollViewAppreance()
        appreance.titleNormalColor = UIColor.gray
        appreance.titleSelectedColor = UIColor.red
        appreance.isScrollEnable = true
        appreance.isShowBottomLine = true
        appreance.bottomLineColor = UIColor.red
        
        /// 设置frame并添加到父视图
        let frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        let pageScrollView = YLPageScrollView(frame: frame, titles: titles, childVCs: childVCs, parentVC: self, appreance: appreance)
        view.addSubview(pageScrollView)
        
        searchButton.frame = CGRect(x: SCREEN_WIDTH-40, y: topStatusView.frameMaxY, width: 40, height: 40)
        searchButton.addTarget(self, action: #selector(searchButtonTouched), for: .touchUpInside)
        view.addSubview(searchButton)
    }

    @objc func searchButtonTouched() {
        navigationController?.pushViewController(VideoSearchVC(), animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


