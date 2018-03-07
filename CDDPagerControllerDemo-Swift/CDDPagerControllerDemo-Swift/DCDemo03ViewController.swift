//
//  DCDemo03ViewController.swift
//  CDDPagerControllerDemo-Swift
//
//  Created by 陈甸甸 on 2018/3/7.
//Copyright © 2018年 陈甸甸. All rights reserved.
//

import UIKit

class DCDemo03ViewController: DCPagerViewController {
    
    // MARK: - LazyLoad
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension DCDemo03ViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        
        isHideProgress = true //隐藏指示条
        selColor = UIColor.orange
        let titles = ["测试01","测试02","测试03"];
        
        for i in 0..<titles.count {
            let vc = UIViewController()
            vc.title = titles[i]
            addChildViewController(vc)
        }
    }
}
