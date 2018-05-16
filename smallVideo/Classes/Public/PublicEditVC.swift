//
//  PublicEditVC.swift
//  smallVideo
//
//  Created by zky on 2018/1/21.
//  Copyright © 2018年 zky. All rights reserved.
//

import UIKit
import AVKit

class PublicEditVC: BaseVC  {
    
    var assetUrl = NSURL()
    
    convenience init(_ assetURL : NSURL) {
        self.init()
        print(assetURL)
        assetUrl = assetURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
