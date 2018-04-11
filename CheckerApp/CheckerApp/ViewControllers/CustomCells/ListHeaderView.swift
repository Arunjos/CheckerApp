//
//  ListHeaderView.swift
//  CheckerApp
//
//  Created by user on 10/04/18.
//  Copyright © 2018 Arun's Technologies. All rights reserved.
//

import UIKit

public typealias TapGestureClosure = (Int) -> ()

class ListHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var bgView: UIView!
    public var tapGestureClosure:TapGestureClosure?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTapGesture()
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action:#selector(headerTapped))
        self.addGestureRecognizer(tap)
    }
    
    @objc func headerTapped() {
        self.tapGestureClosure?(self.tag)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
