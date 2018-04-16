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
        
        self.bgView.layer.cornerRadius = 10
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        self.layer.shadowOpacity = 0.5
        self.bgView.layer.shadowPath = shadowPath.cgPath
    }
    
}
