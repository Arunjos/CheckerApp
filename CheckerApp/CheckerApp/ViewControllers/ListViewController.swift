//
//  ListViewController.swift
//  CheckerApp
//
//  Created by user on 10/04/18.
//  Copyright © 2018 Arun's Technologies. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: properties
    @IBOutlet weak var listTableView: UITableView!
    let cellReuseIdentifier = "TitleCell"
    var selectedIndex = -1
    var selectedHeaderY:CGFloat = 0
    @IBOutlet weak var listTableViewTopCon: NSLayoutConstraint!
    var contentList = [UIColor]()
    
    @IBOutlet weak var subListTableView: UITableView!
    var subListContent = ["asd", "asfasf", "fasfasf"]
    var isSelectedMode = false
    
    @IBOutlet weak var bottomBarSub: UIView!
    @IBOutlet weak var bottomBarMain: UIView!
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var statusBarBgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var statusBarBgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: initialize methods
    func initializeTableView(){
        subListTableView.isHidden = true
        subListTableView.register(UINib(nibName: "ListContentCell", bundle: nil), forCellReuseIdentifier: "SubListCell")
        
        listTableView.register(UINib(nibName: "ListTitleCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        for _ in stride(from: 0, to: 30, by: 1) {
            contentList.append(UIColor(red: random(), green: random(), blue: random(), alpha: 1.0))
        }
    }
    
    //MARK: Supporting Methods
    func addSubListTableView(){
        subListTableView.isHidden = false
        subListContent = ["asd", "asfasf", "fasfasf"]
        subListTableView.reloadData()
    }
    
    func removeSubListTableView(){
        subListTableView.isHidden = true
    }
    
    func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    func animate(tag:Int) {
        // bottom bar animation
        self.bottomBarMain.isHidden = false
        UIView.animate(withDuration: 0.50, animations: {() -> Void in
            self.bottomBarMain.frame.origin.y = self.bottomBarMain.frame.origin.y + self.bottomBarMain.frame.height
        }, completion:{(_ finished: Bool) -> Void in
            self.bottomBarSub.frame.origin.y = self.bottomBarSub.frame.origin.y + self.bottomBarSub.frame.height
            self.bottomBarSub.isHidden = false
            self.bottomBarMain.isHidden = true
            UIView.animate(withDuration: 0.50, animations: {() -> Void in
                self.bottomBarSub.frame.origin.y = self.bottomBarSub.frame.origin.y - self.bottomBarSub.frame.height
            })
        })
        
        // status bar  bg animation
        self.HeaderView.isHidden = true
        self.statusBarBgViewHeight.constant = (self.statusBarBgView.superview?.frame.height)!
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.view.layoutIfNeeded()
            UIApplication.shared.statusBarStyle = .lightContent
            self.setNeedsStatusBarAppearanceUpdate()
        })
        
        //tableview up animation
        self.listTableViewTopCon.constant = 0
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.view.layoutIfNeeded()
        })
        
        // cell aniamtion
        let visibleCells = listTableView.visibleCells
        for cell in visibleCells {
            if cell.tag !=  tag{
                UIView.animate(withDuration: 0.5, animations: {() -> Void in
                    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    cell.alpha = 0
                }, completion:{(_ finished: Bool) -> Void in
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }else{
                UIView.animate(withDuration: 0.7, delay: 0.3, options: [], animations: {() -> Void in
                    self.selectedHeaderY = cell.frame.origin.y
                    cell.frame.origin.y = cell.frame.origin.y - 1
                    cell.frame.origin.y = self.listTableView.contentOffset.y
                }, completion:{(_ finished: Bool) -> Void in
                    self.addSubListTableView()
                })
            }
        }
    }
    
    //MARK: tableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == listTableView{
            return self.contentList.count
        }else{
            return subListContent.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == listTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ListTitleCell
            cell.tag = indexPath.row
            cell.selectionStyle = .none
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1.0
            cell.bgView.backgroundColor = contentList[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubListCell", for: indexPath) as! ListContentCell
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1.0
            cell.contentLabel.text = subListContent[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (tableView == subListTableView) {
            //animates the cell as it is being displayed for the first time
            cell.transform = CGAffineTransform(translationX: 0, y: tableView.rowHeight/2)
            cell.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if tableView == listTableView{
            return 100
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSelectedMode = true
        selectedIndex = indexPath.row
        animate(tag: selectedIndex)
    }
    
    //MARK: Button Clicks
    
    @IBAction func backButtonClicked(_ sender: Any) {
        isSelectedMode = false
        
        // bottom bar back animation
        UIView.animate(withDuration: 0.50, animations: {() -> Void in
            self.bottomBarSub.frame.origin.y = self.bottomBarSub.frame.origin.y + self.bottomBarSub.frame.height
        }, completion:{(_ finished: Bool) -> Void in
            self.bottomBarMain.frame.origin.y = self.bottomBarMain.frame.origin.y + self.bottomBarMain.frame.height
            self.bottomBarSub.isHidden = true
            self.bottomBarMain.isHidden = false
            UIView.animate(withDuration: 0.50, animations: {() -> Void in
                self.bottomBarMain.frame.origin.y = self.bottomBarMain.frame.origin.y - self.bottomBarMain.frame.height
            })
        })
        
        // status bar bg color back animation
        self.statusBarBgViewHeight.constant = 0
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.view.layoutIfNeeded()
        }, completion:{(_ finished: Bool) -> Void in
            UIApplication.shared.statusBarStyle = .default
            self.setNeedsStatusBarAppearanceUpdate()
            self.HeaderView.isHidden = false
        })
        
        // tableview back to position animation
        self.listTableViewTopCon.constant = 20
        UIView.animate(withDuration: 2.0, animations: {() -> Void in
            self.view.layoutIfNeeded()
        })
        
        //remove sublist tableview animation
        var i = 0.0
        for index in stride(from: (subListContent.count-1), through: 0, by: -1){
            let indexPath = IndexPath(row:index, section:0)
            
            if let cell = subListTableView.cellForRow(at: indexPath){
                UIView.animate(withDuration: 0.5, delay: 0.05*i, options: [.curveEaseInOut], animations: {
                    cell.frame.origin.y = (cell.frame.origin.y - cell.frame.height/2)
                    cell.alpha = 0
                }, completion:{(_ finished: Bool) -> Void in
                    self.subListContent.remove(at: index)
                    if self.subListContent.count == 0{
                        self.removeSubListTableView()
                        self.cellBackToPosition()
                    }
                })
                i = i + 1.0
            }
        }
        
    }
    
    func cellBackToPosition(){
        let visibleCells = listTableView.visibleCells
        for cell in visibleCells {
            if cell.tag !=  selectedIndex{
                cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {() -> Void in
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                    cell.alpha = 1
                })
            }else{
                UIView.animate(withDuration: 0.7, animations: {() -> Void in
                    cell.frame.origin.y  = self.selectedHeaderY
                })
            }
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation){
        if isSelectedMode{
            let visibleCells = listTableView.visibleCells
            if selectedIndex >= 0{
                for cell in visibleCells {
                    if cell.tag !=  selectedIndex{
                        cell.alpha = 0
                    }else{
                        self.selectedHeaderY = cell.frame.origin.y
                        cell.frame.origin.y = self.listTableView.contentOffset.y
                    }
                }
            }
        }
    }
        
}

