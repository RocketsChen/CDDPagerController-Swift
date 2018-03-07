//
//  ViewController.swift
//  CDDPagerControllerDemo-Swift
//
//  Created by 陈甸甸 on 2018/3/5.
//  Copyright © 2018年 陈甸甸. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - LazyLoad
    
    private lazy var tableView : UITableView = {

        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TABLEVIEWCELL")
        tableView.frame = CGRect(x: 0, y: 64, width: DCScreenW, height: DCScreenH - 64)
        tableView.rowHeight = 55
        view.addSubview(tableView)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
}


// MARK: - 设置 UI 界面
extension ViewController {
    
    fileprivate func setUpUI(){
        
        automaticallyAdjustsScrollViewInsets = false;
        title = "CDDPagerViewController-Swift"
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
    }
    
    
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TABLEVIEWCELL", for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textLabel?.text = ["🐒","🐱","🐶","🐯"][indexPath.row]
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        let vc = (indexPath.row == 0) ? DCDemo01ViewController() : (indexPath.row == 1) ? DCDemo02ViewController() : (indexPath.row == 2) ? DCDemo03ViewController() :DCDemo04ViewController()
        vc.title = ["🐒","🐱","🐶","🐯"][indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
