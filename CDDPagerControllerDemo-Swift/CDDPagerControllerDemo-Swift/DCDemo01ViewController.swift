//
//  DCDemo01ViewController.swift
//  CDDPagerControllerDemo-Swift
//
//  Created by 陈甸甸 on 2018/3/6.
//Copyright © 2018年 陈甸甸. All rights reserved.
//

import UIKit

class DCDemo01ViewController: DCPagerViewController {
    
    // MARK: - LazyLoad
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
//        dc_setSelectIndex(index: 2) //默认选中
    }
}

// MARK: - 设置 UI 界面
extension DCDemo01ViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
      
        let titles = ["测试01","测试02","测试03","测试04","测试05"];
        
        for i in 0..<titles.count {
            let vc = UIViewController()
            vc.title = titles[i]
            addChildViewController(vc)
        }
    }
}
