//
//  CellIDXibCell.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/22.
//

import UIKit

class CellIDXibCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
