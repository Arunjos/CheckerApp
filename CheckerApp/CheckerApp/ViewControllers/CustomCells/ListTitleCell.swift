//
//  ListTitleCell.swift
//  CheckerApp
//
//  Created by user on 10/04/18.
//  Copyright © 2018 Arun's Technologies. All rights reserved.
//

import UIKit

class ListTitleCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let frame = contentView.frame
        let frameInset = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(10, 10, 10, 10))
        contentView.frame = frameInset
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(at indexPath:IndexPath, contentList:[UIColor]){
        self.tag = indexPath.row
        self.selectionStyle = .none
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1.0
        self.bgView.backgroundColor = contentList[indexPath.row]
    }
    
}
