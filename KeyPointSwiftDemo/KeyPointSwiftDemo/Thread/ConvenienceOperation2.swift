//
//  ConvenienceOperation2.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/26.
//

import Foundation

class ConvenienceOperation2: Operation {
    var number: Int?
    
    convenience init(number: Int, name: String) {
        self.init()
        self.name = name
        self.number = number;
    }
    
    override func main() {
        for i in 0...30 {
            self.number = i
            print("ConvenienceOperation2--当前线程:\(Thread.current)--输出number:\(self.number!)--输出i:\(i)")
        }
    }
}
