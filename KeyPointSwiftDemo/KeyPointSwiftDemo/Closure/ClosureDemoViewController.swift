//
//  ClosureDemoViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/22.
//

import UIKit

class ClosureDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         闭包表达式一般形式：
         {
             (参数列表) -> 返回值类型 in
             statements
         }
         */
        
        //普通闭包
        var closure1:(Int) -> Int
        closure1 = { (a: Int) -> Int in
            return a * a
        }
        print("clourse1调用:\(closure1(11))")
        
        
        //无参数闭包
        var closure2:() -> Void
        closure2 = { () -> Void in
            print("无参数闭包")
        }
        closure2()
        
        //起别名
        typealias ClosureType = () -> Void
        let closure3: ClosureType
        closure3 = { () -> Void in
            print("起别名的闭包")
        }
        closure3()
        
        //作为入参
        closureMethod { (a: Int) in
            print(3 * a)
        }
        
        //作为返回参数
        let closure4 = closureMethod1()
        closure4(10)
        
        
        //作为返回参数
        let closure5 = closureMethod2 { (a:Int) in
            print(4*a)
        }
        closure5(20)
    }
    
    //作为入参
    func closureMethod(closureParam:(Int)->Void) {
        closureParam(3)
    }
    
    //作为返回参数
    func closureMethod1() -> ((Int)->Void) {
        return { (a: Int) -> Void in
            print(a)
        }
    }
    
    //作为入参&返回参数
    func closureMethod2(closureParam:(Int)->Void) -> ((Int)->Void) {
        closureParam(3)
        return { (a: Int) -> Void in
            print(a)
        }
    }
    

    override func loadView() {
        self.view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view.backgroundColor = UIColor.white
    }

}
