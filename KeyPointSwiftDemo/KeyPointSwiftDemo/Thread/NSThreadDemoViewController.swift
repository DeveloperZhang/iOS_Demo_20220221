//
//  NSThreadDemoViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/23.
//

import UIKit

class NSThreadDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        threadMethod(obj: "123")

    }
    
    @objc func threadMethod(obj: Any) {
        print("当前先成为:\(Thread.current)")
        print("参数为:\(obj)")
        for i in 0...9 {
            if i==5 {
                //休眠1秒
//                Thread.sleep(forTimeInterval: 1)
                print("休眠1秒")
                Thread.sleep(until: Date.init(timeInterval: 1, since: Date()))
            }
            print("当前线程为:\(Thread.current),计数器为:\(i)")
        }
        
    }
    
    @IBAction func threadCreateMethod1Action(_ sender: Any) {
        print("当前线程为:\(Thread.current)")
        let thread =  Thread.init(target: self, selector: #selector(threadMethod(obj:)), object: "参数obj")
        // 线程加入线程池等待CPU调度，时间很快，几乎是立刻执行
        thread.name = "子线程1"
        thread.start()
        for i in 0...100 {
            print("当前线程为:\(Thread.current),计数器为:\(i)")
        }
    }
    
    @IBAction func threadCreateMethod2Action(_ sender: Any) {
        print("当前线程为:\(Thread.current)")
        /** 方法二，创建好之后自动启动 */
        Thread.detachNewThreadSelector(#selector(threadMethod), toTarget: self, with: "参数obj2")
        for i in 0...100 {
            print("当前线程为:\(Thread.current),计数器为:\(i)")
        }
    }
    
    @IBAction func threadCreateMethod3Action(_ sender: Any) {
        print("当前线程为:\(Thread.current)")
        //主线程执行
        self.perform(#selector(threadMethod(obj:)), with: "参数obj3")
        /** 方法三，隐式创建，直接启动 */
//        self.performSelector(inBackground: #selector(threadMethod(obj:)), with: "参数obj3")
//        self.performSelector(inBackground: #selector(threadMethod(obj:)), with: "参数obj4")
        for i in 0...100 {
            print("当前线程为:\(Thread.current),计数器为:\(i)")
        }
    }

}
