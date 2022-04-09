//
//  CustomView1.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/22.
//

import UIKit


@IBDesignable
class CustomView1: UIView {  //如果未生效可以先添加该子视图后,删除@IBDesignable再添加@IBDesignable,刷新Xib

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet var view: UIView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib(){
        // 需要这句代码，不能直接写UINib(nibName: "MyView", bundle: nil)，不然不能在storyboard中显示
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomView1", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        self.view.frame = bounds
        self.addSubview(view)
    }

}
