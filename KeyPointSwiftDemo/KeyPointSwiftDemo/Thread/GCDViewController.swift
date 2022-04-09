//
//  GCDViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/26.
//

import UIKit

class GCDViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let dataSourceArray = ["0串行同步", "1串行异步", "2并发同步", "3并发异步", "4主队列同步", "5主队列异步", "6GCD线程之间通信", "7GCD队列组", "8GCD重复执行", "9GCD栅栏", "10数据安全(数据同步)", "11资源竞争信号量"]
    let cellIdentify: String = "CellID";
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentify: String = cellIdentify;
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentify) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentify);
        cell.textLabel?.text = self.dataSourceArray[indexPath.row];
        return cell;
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            syncSerial()
            break
        case 1:
            asyncSerial()
            break
        case 2:
            syncConcurrent()
            break
        case 3:
            asyncConcurrent()
            break
        case 4:
            syncMain()
            break
        case 5:
            asyncMain()
            break
        case 6:
            communicationBetweenThread()
            break
        case 7:
            queueGroup()
            break
        case 8:
            queueRepeat()
            break
        case 9:
            barrierGCD()
            break
        case 10:
            safeData()
            break
        case 11:
            resourceCompetition()
            break
        default:
            break
        }
    }
    
    //串行(连续的)同步--主线程死锁
    func syncSerial() {
        print("\n\n********串行同步********\n\n")
        
        let queue = DispatchQueue.init(label: "test", qos: .unspecified, attributes: .initiallyInactive, autoreleaseFrequency: .inherit, target: .none)

        for i in 1...30 {
            queue.sync {
                print("串行同步\(i)    \(Thread.current)   label is    \(queue.label)")
            }
        }
        print("\n\n********串行同步方法结束********\n\n")
    }
    
    //串行异步
    func asyncSerial() {
        print("\n\n********串行异步********\n\n")
        
        let queue = DispatchQueue.init(label: "test", qos: .unspecified, attributes: .initiallyInactive, autoreleaseFrequency: .inherit, target: .none)

        for i in 1...30 {
            queue.async {
                print("串行异步\(i)    \(Thread.current)   label is    \(queue.label)")
            }
        }
        print("\n\n********串行异步方法结束********\n\n")
    }
    
    //并发同步
    func syncConcurrent() {
        print("\n\n********并发同步********\n\n")
        
        /**
         * label:String : 队列的标识符，方便在调试工具（如 Instruments, 奔溃日志）中找到对应的信息。
         * qos: DispatchQoS : 该值确定系统安排任务执行的优先级。QoS类对要在DispatchQueue上执行的工作进行了分类。 通过指定任务的qos，可以表明任务对应用程序的重要性。 在安排任务时，系统会优先处理服务级别较高的任务。因为高优先级的工作比低优先级的工作执行得更快，资源更多，所以与低优先级的工作相比，通常需要更多的精力。 为您的应用执行的工作准确地指定适当的QoS类可确保您的应用具有响应能力和能源效率。
         *      - public static let background: DispatchQoS 在所有任务中具有最低的优先级。针对当APP在后台运行的时候，需要处理的任务
         *      - public static let utility: DispatchQoS 优先级低于default, userInitiated, userInteractive，高于background。 将类型分配给不会阻止用户继续使用您的应用程序的任务。 例如，您可以将此类分配给长时间运行的任务，而这些任务的进度用户并未积极关注。
         *      - public static let default: DispatchQoS 优先级低于 userInitiated, userInteractive，但高于utility和background。将此类型分配给应用启动或代表用户执行活动的任务或队列。
         *      - public static let userInitiated: DispatchQoS 优先级仅仅低于 userInteractive。 将此类型分配给可以为用户的操作提供即时结果的任务，或者将阻止用户使用您的应用的任务。 例如，您可以使用此类型加载要显示给用户的电子邮件的内容。
         *      - public static let userInteractive: DispatchQoS 在所有任务中具有最高的优先级。将此类型分配给可与用户交互或主动更新应用程序的用户界面的任务或队列。 例如，将此用于动画类或跟踪事件。
         *      - public static let unspecified: DispatchQoS 未设置优先级
         * attributes: DispatchQueue.Attributes 与队列关联的属性。 包括并发属性以创建可以同时执行任务的调度队列。 如果省略该属性，则分派队列将串行执行任务。
         *      - static let concurrent: DispatchQueue.Attributes 如果不存在此属性，则队列按先进先出（FIFO）顺序依次调度任务。也就是只要不设置这个属性那么创建的队列就是串行队列
         *      - static let initiallyInactive: DispatchQueue.Attributes 通常新创建的队列已提交的块会立即执行。 使用此属性可以防止队列调度块，直到调用其activate（）方法为止。
         * autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency 调度队列自动释放对象的频率。
         *      - inherit 创建的队列的默认行为。
         *      - workItem 队列在执行块之前配置一个自动释放池，并在块执行完之后释放该池中的对象。
         *      - never 队列未在执行的块周围设置自动释放池。此选项是系统定义的全局队列的默认行为。
         * target: DispatchQueue? 要在其上执行块的目标队列。 如果希望系统提供适合于当前对象的队列，请指定DISPATCH_TARGET_QUEUE_DEFAULT。
         *
         *
         *
         *
         */
        let queue = DispatchQueue.init(label: "test", qos: .unspecified, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        //        let queue = DispatchQueue.init(label: "test")
                //一个全局系统队列label是com.apple.root.default-qos
        //        let queue = DispatchQueue.global()
        
        for i in 1...30 {
            queue.sync {
                print("并发同步-\(i)    \(Thread.current)   label is    \(queue.label)")
            }
        }
        print("\n\n********并发同步方法结束********\n\n")
    }
    
    //并发异步
    func asyncConcurrent() {
        print("\n\n********并发异步********\n\n")
        let queue = DispatchQueue.init(label: "test", qos: .unspecified, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        
        for i in 1...30 {
            queue.async {
                print("并发异步\(i)    \(Thread.current)   label is    \(queue.label)")
            }
        }
        print("\n\n********并发异步方法结束********\n\n")
    }
    
    //主队列同步--造成了死锁
    func syncMain() {
        /**
         主队列同步造成死锁的原因：

         1.如果在主线程中运用主队列同步，也就是把任务放到了主线程的队列中。

         2.而同步对于任务是立刻执行的，那么当把第一个任务放进主队列时，它就会立马执行。

         3.可是主线程现在正在处理syncMain方法，任务需要等syncMain执行完才能执行。

         4.syncMain执行到第一个任务的时候，又要等第一个任务执行完才能往下执行第二个和第三个任务。

         这样syncMain方法和第一个任务就开始了互相等待，形成了死锁。
         */
        
        print("\n\n********主队列同步********\n\n")
        let queue = DispatchQueue.main
        //相当于
//        print("\n\n********主队列同步********\n\n")
//        let queue = DispatchQueue.init(label: "test", qos: .unspecified, attributes: .initiallyInactive, autoreleaseFrequency: .inherit, target: .none)

        for i in 1...30 {
            queue.sync {
                print("主队列同步\(i)    \(Thread.current)   label is    \(queue.label)")
            }
        }
        print("\n\n********主队列同步方法结束********\n\n")
    }
    
    //主队列异步
    func asyncMain() {
        //在主线程中串行执行
        print("\n\n********主队列异步********\n\n")
        let queue = DispatchQueue.main
        for i in 1...30 {
            queue.async {
                print("主队列异步\(i)    \(Thread.current)   label is    \(queue.label)")
            }
        }
        print("\n\n********主队列异步方法结束********\n\n")
    }
    
    
    //线程间通信
    func communicationBetweenThread() {
        print("\n\n********线程间通信********\n\n")
        let label = UILabel.init(frame: self.view.frame)
        label.backgroundColor = UIColor.black
        label.alpha = 0.2
        label.text = "加载中"
        label.textAlignment = .center
        label.textColor = UIColor.green
        self.view.addSubview(label)
        print("\n\n********线程间通信********\n\n")
        let queue = DispatchQueue.global()
        queue.async {
            print("正在执行耗时操作...")
            let result = "Hello"
            Thread.sleep(forTimeInterval: 3.0)
            DispatchQueue.main.async {
                print("耗时操作结束输出结果:\(result)...")
                label.removeFromSuperview()
            }
        }
    }
    
    //队列组
    func queueGroup() {
        //所以任务执行完成后再执行notify方法
        print("\n\n********队列组********\n\n")
        let group = DispatchGroup.init()
        let queue1 = DispatchQueue.global()
        let queue2 = DispatchQueue.global()
        let queue3 = DispatchQueue.main
//        let queue3 = DispatchQueue.global()
        //DispatchWorkItem 要完成的任务对象
        queue1.async(group: group, execute: DispatchWorkItem.init(block: {
            for i in 1...29 {
                print("队列组1-\(i)：有一个耗时操作完成！ \(Thread.current)")
            }
        }))
        queue2.async(group: group, execute: DispatchWorkItem.init(block: {
            for i in 1...29 {
                print("队列组2-\(i)：有一个耗时操作完成！ \(Thread.current)")
            }
        }))
        group.notify(queue:queue3 , work: DispatchWorkItem.init(block: {
            print("队列组：前面的耗时操作都完成了，回到主线程进行相关操作  \(Thread.current)")
        }))
    }
    
    //重复执行
    func queueRepeat() {
        print("\n\n********重复执行********\n\n")
        //异步,类似dispatch_apply
        DispatchQueue.concurrentPerform(iterations: 5) { (index) in
            print("重复执行\(index)     \(Thread.current)")
        }
    }
    
    //栅栏
    func barrierGCD() {
        //线程依赖
        print("\n\n********栅栏********\n\n")
        let queue = DispatchQueue.init(label: "test", qos: .unspecified, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        
        for i in 1...30 {
            queue.async {
                print("并发异步\(i)    \(Thread.current)   label is    \(queue.label)")
            }
        }
        let queue1 = DispatchQueue.init(label: "test1", qos: .unspecified, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        
        for i in 1...30 {
            queue1.async {
                print("并发异步\(i)    \(Thread.current)   label is    \(queue1.label)")
            }
        }
        
        let workItem =  DispatchWorkItem.init(qos: .utility, flags: .barrier) {
            for i in 1...30 {
                print("并发异步\(i)    \(Thread.current)  --queue2")
            }
//            ******* 并发异步执行，但是2一定在0 1后面 *********
        }
        let queue2 = DispatchQueue.init(label: "test2", qos: .unspecified, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        queue2.async(execute: workItem)
    }

    //数据安全同步
    func safeData() {
        print("\n\n********数据安全同步********\n\n")
        var number = 1;
        let queue = DispatchQueue.init(label: "test", qos: .unspecified, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        for i in 1...30 {
            queue.async {
                objc_sync_enter(self)
                number += 1
                print("并发异步\(i)    \(Thread.current)  increase label is    \(queue.label) number is \(number)")
                objc_sync_exit(self)
            }
        }
        
        for i in 1...30 {
            queue.async {
                objc_sync_enter(self)
                number -= 1
                print("并发异步\(i)    \(Thread.current)  reduce  label is    \(queue.label) number is \(number)")
                objc_sync_exit(self)
            }
        }
    }
    
    //资源竞争 操作依赖
    func resourceCompetition() {
        print("\n\n********资源竞争********\n\n")
        
        let queue = DispatchQueue(label: "test")
        let sema = DispatchSemaphore(value: 1)
        queue.async {
            Thread.sleep(forTimeInterval: 1)
            print("task1 done")
            let sign = sema.signal()
            print("sign: \(sign)")
        }
        //阻塞主线程所以无法走到task2
        var result = sema.wait(timeout: .distantFuture)
        print("result is:\(result)")
        
        queue.async {
            Thread.sleep(forTimeInterval: 0.2)
            print("task2 done")
            let sign = sema.signal()
            print("sign: \(sign)")
        }
        result = sema.wait(timeout: .distantFuture)
        print("result is:\(result)")
    }

}
