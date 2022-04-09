//
//  CellIDCodeCell.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/22.
//

import UIKit

class CellIDCodeCell: UITableViewCell {

    var myLabel : UILabel = UILabel()
    private var _contentLabelString: String?

    
    var contentLabelString: String? {
        get {
            return _contentLabelString
        }
        set {
            _contentLabelString = newValue
            self.myLabel.text = _contentLabelString
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(myLabel)
    
        let vCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[label]", options: [], metrics: nil, views: ["label" : myLabel])
        let hCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[label]", options: [], metrics: nil, views: ["label" : myLabel])
        self.contentView.addConstraints(vCons)
        self.contentView.addConstraints(hCons)
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
