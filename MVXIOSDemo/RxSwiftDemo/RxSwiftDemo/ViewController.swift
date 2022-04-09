//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Vicent on 2022/4/9.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import Action

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    public var flag: BehaviorRelay<Bool>?
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RxSwift Demo")
        test3()
    }

    func test3() {
        // 创建序列（后续讲解序列的创建）
        let observable = Observable.of("A", "B", "C")
        // 序列的订阅
        observable.subscribe(onNext: { element in
            print(element)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        }).disposed(by: disposeBag)
    }
    
    func test2() {
        // 创建序列（后续讲解序列的创建）
        let observable = Observable.of("A", "B", "C")
        // 序列的订阅
        observable.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    func test1() {
        self.flag = BehaviorRelay(value: false)
        
        flag?.subscribe(onNext: { flag in
            print("flag is chage to: \(flag)")
        }).disposed(by: disposeBag)
        
        flag?.accept(true)
        
        self.myButton.rx.action = CocoaAction {
            print("button clicked")
            return Observable.empty()
        }
    }

}

