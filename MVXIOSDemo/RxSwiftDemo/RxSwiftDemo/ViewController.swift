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

