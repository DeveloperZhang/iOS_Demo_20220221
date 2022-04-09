//
//  ViewController.swift
//  CarthageDemo
//
//  Created by Vicent on 2022/2/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User(JSONString: "{\"username\":\"张三\"}")
        print("\(#function):\(String(describing: user?.toJSONString(prettyPrint: true)))")
    }
}

