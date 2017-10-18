//
//  KYNavC.swift
//  SmallVideo
//
//  Created by zky on 2017/8/24.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class KYNavC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarHidden(false, animated: false)
        navigationBar.isHidden = true
        
        
    }
    
    func navigationCanDragBack(canDragBack : Bool) {
        interactivePopGestureRecognizer?.isEnabled  = canDragBack
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
