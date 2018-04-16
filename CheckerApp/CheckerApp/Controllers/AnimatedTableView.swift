//
//  AnimatedTableView.swift
//  CheckerApp
//
//  Created by user on 16/04/18.
//  Copyright © 2018 Arun's Technologies. All rights reserved.
//

import UIKit

public typealias AnimationCompletionHandler = () -> ()
class AnimatedTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var selectedCellYPosition:CGFloat?
    
    func cellMoveTopAnimation(selectedIndex:Int, completeionClosure:@escaping AnimationCompletionHandler) {
        // cell aniamtion
        let visibleCells = self.visibleCells
        for cell in visibleCells {
            if cell.tag !=  selectedIndex{
                UIView.animate(withDuration: 0.5, animations: {() -> Void in
                    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    cell.alpha = 0
                }, completion:{(_ finished: Bool) -> Void in
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }else{
                UIView.animate(withDuration: 0.7, delay: 0.3, options: [], animations: {() -> Void in
                    self.selectedCellYPosition = cell.frame.origin.y
                    cell.frame.origin.y = cell.frame.origin.y - 1
                    cell.frame.origin.y = self.contentOffset.y
                }, completion:{(_ finished: Bool) -> Void in
                    completeionClosure()
                })
            }
        }
    }
    
    func returnTopCellAnimation(selectedIndex:Int, completeionClosure:@escaping AnimationCompletionHandler) {
        
        if let selectedCellYPosition = self.selectedCellYPosition{
            let visibleCells = self.visibleCells
            for cell in visibleCells {
                if cell.tag !=  selectedIndex{
                    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {() -> Void in
                        cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                        cell.alpha = 1
                    })
                }else{
                    UIView.animate(withDuration: 0.7, animations: {() -> Void in
                        cell.frame.origin.y  = selectedCellYPosition
                    })
                }
            }
        }
    }
    
    func rotationHandlerForMoveTopAnimation(selectedIndex:Int){
        let visibleCells = self.visibleCells
        if selectedIndex >= 0{
            for cell in visibleCells {
                if cell.tag !=  selectedIndex{
                    cell.alpha = 0
                }else{
                    self.selectedCellYPosition = cell.frame.origin.y
                    cell.frame.origin.y = self.contentOffset.y
                }
            }
        }
    }
    
    func removeCellsFadeAnimation(contentCount:Int, completeionClosure:@escaping AnimationCompletionHandler) {
        var animationIncrement = 0.0
        for index in stride(from: (contentCount-1), through: 0, by: -1){
            let indexPath = IndexPath(row:index, section:0)
            
            if let cell = self.cellForRow(at: indexPath){
                UIView.animate(withDuration: 0.5, delay: 0.05*animationIncrement, options: [.curveEaseInOut], animations: {
                    cell.frame.origin.y = (cell.frame.origin.y - cell.frame.height/2)
                    cell.alpha = 0
                }, completion:{(_ finished: Bool) -> Void in
                    if index == 0{
                        completeionClosure()
                    }
                })
                animationIncrement = animationIncrement + 1.0
            }
        }
    }
}
