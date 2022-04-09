//
//  ScrollDemoViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/21.
//

import UIKit

class ScrollDemoViewController: UIViewController {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ScrollViewUI"
        // Do any additional setup after loading the view.
        
        self.contentLabel.text = "1.设置ScrollView的上下左右约束与父视图\n\n2.创建一个View作为ScrollView的自视图用于撑开ScrollView\n\n3.设置View的上下左右约束与父视图\n\n4.指定View的宽度和高度,这样ScrollView就能自行计算出其contentSize了\n\n"
        
    }

}
