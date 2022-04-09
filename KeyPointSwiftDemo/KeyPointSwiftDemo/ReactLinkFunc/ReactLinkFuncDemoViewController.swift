//
//  ReactLinkFuncDemoViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/26.
//

import UIKit

class ReactLinkFuncDemoViewController: UIViewController {

    let kvo = KVOObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.kvo.addObserver(self, forKeyPath: "myName", options: [.new, .old], context: nil)
    }
    
    
    @IBAction func reactAction(_ sender: Any) {
        print(#function)
        let numberOne: Int = Int(arc4random_uniform(100))
        self.kvo.myName = "\(numberOne)"
    }
    
    @IBAction func linkAction(_ sender: Any) {
        _ = self.testLinkMethod().testLinkMethod1()
    }
    
    @IBAction func funcAction(_ sender: Any) {
        testFuncMethod { (a: Int) in
            print("\(#function):\(a * a)")
        }
    }
    
    func testLinkMethod() -> ReactLinkFuncDemoViewController {
        print(#function)
        return self;
    }
    
    func testLinkMethod1() -> ReactLinkFuncDemoViewController {
        print(#function)
        return self;
    }
    
    func testFuncMethod(clourseParam:(Int)->Void) {
        clourseParam(10)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("keyPath is:\(keyPath!)")
        if let old = change?[.oldKey] {
            print("old is:\(old)")
        }
        
        if let new = change?[.newKey] {
            print("new is:\(new)")
        }
    }
    

}
