//
//  ListContentCell.swift
//  CheckerApp
//
//  Created by user on 12/04/18.
//  Copyright © 2018 Arun's Technologies. All rights reserved.
//

import UIKit

class ListContentCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frame = contentView.frame
        let frameInset = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(0, 10, 0, 10))
        contentView.frame = frameInset
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(at indexPath:IndexPath, contentList:[String]){
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1.0
        self.contentLabel.text = contentList[indexPath.row]
    }
    
    func animateCellInsert(){
        self.transform = CGAffineTransform(translationX: 0, y: -5)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.05*Double(self.tag), options: [.curveEaseInOut], animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
            self.alpha = 1
        }, completion: nil)
    }
    
}
