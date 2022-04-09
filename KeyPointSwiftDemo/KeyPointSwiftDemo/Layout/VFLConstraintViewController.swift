//
//  VFLConstraintViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/21.
//

import UIKit

class VFLConstraintViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "VFL约束"
        
        let subView = UIView.init()
        subView.backgroundColor = UIColor.green
        //设置需要设置约束的视图使用约束
        subView.translatesAutoresizingMaskIntoConstraints = false
        //先添加子视图再添加约束
        self.view.addSubview(subView);
        
        //垂直方向居中
        let hConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[view(100)]", options:[], metrics: nil, views: ["view":subView])

        let wConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[view(100)]", options:[], metrics: nil, views: ["view":subView])
        //TODO VFL暂时不清楚如何居中
        let centerYCons = NSLayoutConstraint.init(item: subView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)

    
        self.view.addConstraints(hConstraint)
        self.view.addConstraints(wConstraint)
        self.view.addConstraint(centerYCons)
        
        
        
        
        
    }
    

    override func loadView() {
        self.view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view.backgroundColor = UIColor.white
        
    }

}
