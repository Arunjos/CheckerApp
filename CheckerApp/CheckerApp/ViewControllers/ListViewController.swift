//
//  ListViewController.swift
//  CheckerApp
//
//  Created by user on 10/04/18.
//  Copyright © 2018 Arun's Technologies. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var listTitleTableView: AnimatedTableView!
    let cellReuseIdentifier = "TitleCell"
    @IBOutlet weak var titleTableViewTopCon: NSLayoutConstraint!
    var titleList = [UIColor]()
    
    var selectedIndex = -1
    var selectedHeaderY:CGFloat = 0
    
    
    @IBOutlet weak var listContentTableview: AnimatedTableView!
    var contentList = ["1", "2", "3"]
    
    var isAnimatedMode = false
    
    @IBOutlet weak var contentSceneBottomView: UIView!
    @IBOutlet weak var titleSceneBottomView: UIView!
    
    @IBOutlet weak var titleSceneHeaderView: UIView!
    
    @IBOutlet weak var contentSceneHeaderBgViewHeightCon: NSLayoutConstraint!
    @IBOutlet weak var contentSceneHeaderBgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Initialize Methods
    func initializeTableView(){
        listContentTableview.isHidden = true
        listContentTableview.register(UINib(nibName: "ListContentCell", bundle: nil), forCellReuseIdentifier: "SubListCell")
        
        listTitleTableView.register(UINib(nibName: "ListTitleCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        self.contentSceneBottomView.isHidden = true
    }
    
    //MARK: Supporting Methods
    func addSubListTableView(){
        listContentTableview.isHidden = false
        contentList = ["1", "2", "3"]
        listContentTableview.reloadData()
    }
    
    func removeSubListTableView(){
        listContentTableview.isHidden = true
    }
    
    //MARK: Animation Methods
    func animateViews() {
        // bottom view animation
        self.titleSceneBottomView.isHidden = false
        UIView.animate(withDuration: 0.50, animations: {() -> Void in
            self.titleSceneBottomView.frame.origin.y = self.titleSceneBottomView.frame.origin.y + self.titleSceneBottomView.frame.height
        }, completion:{(_ finished: Bool) -> Void in
            self.contentSceneBottomView.frame.origin.y = self.contentSceneBottomView.frame.origin.y + self.contentSceneBottomView.frame.height
            self.contentSceneBottomView.isHidden = false
            self.titleSceneBottomView.isHidden = true
            UIView.animate(withDuration: 0.50, animations: {() -> Void in
                self.contentSceneBottomView.frame.origin.y = self.contentSceneBottomView.frame.origin.y - self.contentSceneBottomView.frame.height
            })
        })
        
        // header bg animation
        self.titleSceneHeaderView.isHidden = true
        self.contentSceneHeaderBgViewHeightCon.constant = (self.contentSceneHeaderBgView.superview?.frame.height)!
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.view.layoutIfNeeded()
            UIApplication.shared.statusBarStyle = .lightContent
            self.setNeedsStatusBarAppearanceUpdate()
        })
        
        //title tableview move up animation
        self.titleTableViewTopCon.constant = 0
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func getBackAnimatedViews() {
        // bottom view back animation
        UIView.animate(withDuration: 0.50, animations: {() -> Void in
            self.contentSceneBottomView.frame.origin.y = self.contentSceneBottomView.frame.origin.y + self.contentSceneBottomView.frame.height
        }, completion:{(_ finished: Bool) -> Void in
            self.titleSceneBottomView.frame.origin.y = self.titleSceneBottomView.frame.origin.y + self.titleSceneBottomView.frame.height
            self.contentSceneBottomView.isHidden = true
            self.titleSceneBottomView.isHidden = false
            UIView.animate(withDuration: 0.50, animations: {() -> Void in
                self.titleSceneBottomView.frame.origin.y = self.titleSceneBottomView.frame.origin.y - self.titleSceneBottomView.frame.height
            })
        })
        
        // content tableview remove content
        self.listContentTableview.removeCellsFadeAnimation(contentCount: contentList.count, completeionClosure: {
            self.contentList.removeAll()
            self.removeSubListTableView()
            
            // status view bg color back animation
            self.contentSceneHeaderBgViewHeightCon.constant = 0
            UIView.animate(withDuration: 1.0, animations: {() -> Void in
                self.view.layoutIfNeeded()
            }, completion:{(_ finished: Bool) -> Void in
                UIApplication.shared.statusBarStyle = .default
                self.setNeedsStatusBarAppearanceUpdate()
                self.titleSceneHeaderView.isHidden = false
            })
            
            // title tableview back to position animation
            self.titleTableViewTopCon.constant = 20
            UIView.animate(withDuration: 0.50, animations: {() -> Void in
                self.view.layoutIfNeeded()
            })
            
            // title tableview get back cells
            self.listTitleTableView.returnTopCellAnimation(selectedIndex: self.selectedIndex, completeionClosure: {})
        })
    }
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == listTitleTableView{
            return 30 //self.titleList.count //now default set
        }else{
            return contentList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == listTitleTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ListTitleCell
            cell.setupCell(at: indexPath, contentList: titleList)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubListCell", for: indexPath) as! ListContentCell
            cell.setupCell(at: indexPath, contentList:contentList)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (tableView == listContentTableview) {
            if let cell = cell as? ListContentCell{
                cell.animateCellInsert()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if tableView == listTitleTableView{
            return CGFloat(Constants.TITLE_TABLE_VIEW.ROW_HEIGHT)
        }else{
            return CGFloat(Constants.CONTENT_TABLE_VIEW.ROW_HEIGHT)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isAnimatedMode != true{
            isAnimatedMode = true
            selectedIndex = indexPath.row
            animateViews()
            if let currentTableview = tableView as? AnimatedTableView{
                currentTableview.cellMoveTopAnimation(selectedIndex: indexPath.row, completeionClosure:{
                    self.addSubListTableView()
                })
            }
        }
    }
    
    //MARK: Button Clicks
    @IBAction func backButtonClicked(_ sender: Any) {
        isAnimatedMode = false
        getBackAnimatedViews()
    }
    
    //MARK: Rotation Dectect Method
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation){
        if isAnimatedMode{
            listTitleTableView.rotationHandlerForMoveTopAnimation(selectedIndex: selectedIndex)
        }
    }
}

