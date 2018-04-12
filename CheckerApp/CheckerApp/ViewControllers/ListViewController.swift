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
    let headerReuseIdentifier = "ListHeaderView"
    var selectedIndex = 0
    var selectedHeaderY:CGFloat = 0
    
    var contentList = [UIColor]()
    var rowsInSection = [[UIColor]]()
    
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
        listTableView.register(UINib(nibName: "ListTitleCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        for _ in stride(from: 0, to: 30, by: 1) {
            contentList.append(UIColor(red: random(), green: random(), blue: random(), alpha: 1.0))
            rowsInSection.append([])
        }
        let headerNib = UINib(nibName: "ListHeaderView", bundle: nil)
        listTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
    }
    
    
    
    //MARK: Supporting Methods
    public func headerTapped(tag:Int) {
//        self.listTableView.moveSection(tag, toSection: 0)
        selectedIndex = tag
        animate(tag: tag)
//        self.contentList.removeSubrange(0..<tag)
//        UIView.animate(withDuration: 5.0) {
//        self.listTableView.deleteSections(IndexSet(0..<tag), with: UITableViewRowAnimation.none)
//        }
//        self.listTableView.deleteSections(IndexSet((tag+1)...(self.contentList.count-1)), with: UITableViewRowAnimation.fade)
    }
    
    func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    func animate(tag:Int) {
        let visibleHeaderList = listTableView.visibleSectionHeaders
        let indexesOfVisibleSections = self.listTableView.indexesOfVisibleSections
        var index = 0
        for header in visibleHeaderList {
            if indexesOfVisibleSections[index] !=  tag{
                UIView.animate(withDuration: 2.0, animations: {() -> Void in
                    header.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    header.alpha = 0
                }, completion:{(_ finished: Bool) -> Void in
                    if index == self.listTableView.indexesOfVisibleSections.count{
                        self.rowsInSection[tag] = [UIColor.black]
                        self.listTableView.beginUpdates()
                        self.listTableView.insertRows(at: [IndexPath(row: 0, section: tag)], with: .none)
                        self.listTableView.endUpdates()
                        
                    }
                })
            }else{
                UIView.animate(withDuration: 2.0, animations: {() -> Void in
                    self.selectedHeaderY = header.frame.origin.y
                    header.frame.origin.y = self.listTableView.contentOffset.y
                })
            }
            index = index+1
//            UIView.animate(withDuration: 2.0, animations: {() -> Void in
//                header.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//            }, completion: {(_ finished: Bool) -> Void in
//                UIView.animate(withDuration: 2.0, animations: {() -> Void in
//                    header.transform = CGAffineTransform(scaleX: 1, y: 1)
//                })
//            })
            
//            header.frame = CGRect(x: 0, y: header.frame.origin.y, width: header.frame.size.width, height: header.frame.size.height)
//            UIView.animate(withDuration: 1.0) {
//                cell.frame = CGRect(x: self.listTableView.frame.size.width, y: cell.frame.origin.y, width: cell.frame.size.width, height: cell.frame.size.height)
//            }
        }
    }
    
    //MARK: tableView methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.contentList.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return rowsInSection[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier ) as! ListHeaderView
        headerView.transform = CGAffineTransform(scaleX: 1, y: 1)
        headerView.alpha = 1
        headerView.tag = section
        headerView.tapGestureClosure = {(tag) in
            self.headerTapped(tag: tag)
        }
        headerView.bgView.backgroundColor = self.contentList[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ListTitleCell
        cell.bgView.backgroundColor = rowsInSection[indexPath.section][indexPath.row]//self.contentList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.frame.origin.y = self.listTableView.contentOffset.y + 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.listTableView.moveRow(at: indexPath, to: IndexPath(row:0, section: 0))
        animate(tag: 0)
//        self.contentList.remove(at: indexPath.row)
//        UIView.animate(withDuration: 5.0) {
//            self.listTableView.deleteRows(at:[indexPath] , with: UITableViewRowAnimation.none)
////            self.listTableView.deleteSections(IndexSet(0..<indexPath.row), with: UITableViewRowAnimation.none)
//        }
    }
    
    //MARK: Button Clicks
    
    @IBAction func backButtonClicked(_ sender: Any) {
        let visibleHeaderList = listTableView.visibleSectionHeaders
        var index = 0
        for header in visibleHeaderList {
            if self.listTableView.indexesOfVisibleSections[index] !=  selectedIndex{
                UIView.animate(withDuration: 2.0, animations: {() -> Void in
                    header.transform = CGAffineTransform(scaleX: 1, y: 1)
                    header.alpha = 1
                })
            }else{
                UIView.animate(withDuration: 2.0, animations: {() -> Void in
                    header.frame.origin.y  = self.selectedHeaderY
                })
            }
            index = index+1
        }
    }
    
}

public extension UITableView{
    var indexesOfVisibleSections: [Int] {
        // Note: We can't just use indexPathsForVisibleRows, since it won't return index paths for empty sections.
        var visibleSectionIndexes = [Int]()
        
        for i in 0..<numberOfSections {
            var headerRect: CGRect?
            // In plain style, the section headers are floating on the top, so the section header is visible if any part of the section's rect is still visible.
            // In grouped style, the section headers are not floating, so the section header is only visible if it's actualy rect is visible.
            if (self.style == .plain) {
                headerRect = rect(forSection: i)
            } else {
                headerRect = rectForHeader(inSection: i)
            }
            if headerRect != nil {
                // The "visible part" of the tableView is based on the content offset and the tableView's size.
                let visiblePartOfTableView: CGRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: bounds.size.width, height: bounds.size.height)
                if (visiblePartOfTableView.intersects(headerRect!)) {
                    visibleSectionIndexes.append(i)
                }
            }
        }
        return visibleSectionIndexes
    }
    
    var visibleSectionHeaders: [UITableViewHeaderFooterView] {
        var visibleSects = [UITableViewHeaderFooterView]()
        for sectionIndex in indexesOfVisibleSections {
            if let sectionHeader = headerView(forSection: sectionIndex) {
                visibleSects.append(sectionHeader)
            }
        }
        
        return visibleSects
    }
}

