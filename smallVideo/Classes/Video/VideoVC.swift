//
//  VideoVC.swift
//  SmallVideo
//
//  Created by zky on 2017/8/24.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class VideoVC: BaseVC, WHC_PageViewDelegate {
    
    var categoryView =  [VideoCategoryView(),VideoCategoryView(),VideoCategoryView(),VideoCategoryView(),VideoCategoryView(),VideoCategoryView(),VideoCategoryView()]
    
    let searchButton = UIButton()
    fileprivate let layoutParam = WHC_PageViewLayoutParam()
    fileprivate let pageView = WHC_PageView()
    fileprivate var didLoadPageView = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let topStatusView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
        topStatusView.backgroundColor = rgb(52, 53, 57)
        view.addSubview(topStatusView)
        setupPageView()
    }
    
    //// 加载pageView布局
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !didLoadPageView {
            didLoadPageView = true
            pageView.layoutIfNeeded()
            pageView.layoutParam = layoutParam
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: - WHC_PageView
extension VideoVC {

    fileprivate func setupPageView() {
    
        pageView.delegate = self
        self.view.addSubview(pageView)
        
        pageView.snp.makeConstraints { (make) ->Void in
            make.top.equalTo(20)
            make.bottom.equalTo(-49)
            make.left.right.equalTo(self.view)
        }
        
        layoutParam.titles = ["推荐","热点","知识书籍","为人处世","健康养生","体育健身","游戏"]
        layoutParam.itemWidth = 80 /***如果标题很多一屏放不下需要设定每个标题的固定宽度否则可以忽略***/
        layoutParam.selectedTextColor = UIColor.orange
        layoutParam.normalBackgorundColor = UIColor.white
        layoutParam.normalTextColor = UIColor.black
        layoutParam.selectedBackgorundColor = UIColor(red: 252 / 255.0, green: 240 / 255.0, blue: 220 / 255.0, alpha: 1.0)
    }
    
    
    //MARK: - WHC_PageViewDelegate -
    func whcPageViewStartLoadingViews() -> [UIView]! {
        return categoryView
    }
    
    func whcPageView(pageView: WHC_PageView, willUpdateView view: UIView, index: Int) {
        
        if  let tableView = view as? VideoCategoryView {
            tableView.loadDataArr(layoutParam.titles[index], index)
        }
    }
}
