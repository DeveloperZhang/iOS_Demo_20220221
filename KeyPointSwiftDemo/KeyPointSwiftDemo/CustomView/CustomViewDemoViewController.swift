//
//  CustomViewDemoViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/22.
//

import UIKit

class CustomViewDemoViewController: UIViewController {

    @IBOutlet weak var customView2: CustomView1!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customView1 = CustomView()
        self.view.addSubview(customView1)
        customView1.translatesAutoresizingMaskIntoConstraints = false
        let hConst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[customView1]-|", options: [], metrics: nil, views: ["customView1" : customView1])
        let vConst = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[customView1(100)]", options: [], metrics: nil, views: ["customView1" : customView1])
        self.view.addConstraints(vConst)
        self.view.addConstraints(hConst)
        
        self.customView2.myLabel.text = "Xib自定义"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
