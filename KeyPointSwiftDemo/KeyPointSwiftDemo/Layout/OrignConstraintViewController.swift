//
//  OrignConstraintViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/21.
//

import UIKit

class OrignConstraintViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "原始约束"
        
        let subView = UIView.init()
        subView.backgroundColor = UIColor.green
        //设置需要设置约束的视图使用约束
        subView.translatesAutoresizingMaskIntoConstraints = false
        //先添加子视图再添加约束
        self.view.addSubview(subView);
        //距离父视图左侧100
        let leftCons = NSLayoutConstraint.init(item: subView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 100)
        //距离父视图顶部100
//        let topCons = NSLayoutConstraint.init(item: subView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 100)
        //Y轴居中
        let centerYCons = NSLayoutConstraint.init(item: subView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        //高度为100
        let heightCons = NSLayoutConstraint.init(item: subView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        //宽度为100
        let widthCons = NSLayoutConstraint.init(item: subView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        //位置约束加载父视图上
        self.view.addConstraint(leftCons)
//        self.view.addConstraint(topCons)
        self.view.addConstraint(centerYCons)
        //宽高加在自身上
        subView.addConstraints([widthCons, heightCons])
        
    }
    

    override func loadView() {
        self.view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view.backgroundColor = UIColor.white
    }

}
