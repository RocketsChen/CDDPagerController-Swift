//
//  DCDemo04ViewController.swift
//  CDDPagerControllerDemo-Swift
//
//  Created by 陈甸甸 on 2018/3/7.
//Copyright © 2018年 陈甸甸. All rights reserved.
//

import UIKit

class DCDemo04ViewController: DCPagerViewController {
    
    // MARK: - LazyLoad
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension DCDemo04ViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        
        topDistance = 50

        let titles = ["测试01","测试02","测试03","测试04","测试05","测试06","测试07"];
        for i in 0..<titles.count {
            let vc = UIViewController()
            vc.title = titles[i]
            addChildViewController(vc)
        }
        
    }
}
