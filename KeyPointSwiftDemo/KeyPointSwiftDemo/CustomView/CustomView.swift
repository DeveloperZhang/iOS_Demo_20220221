//
//  CustomView.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/22.
//

import UIKit

class CustomView: UIView {

    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.green
        let label = UILabel()
        label.text = "CustomView"
        label.backgroundColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        let hCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: ["label" : label])
        let vCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-|", options: [], metrics: nil, views: ["label" : label])
        
        self.addConstraints(hCons)
        self.addConstraints(vCons)
        
    }
    

}
