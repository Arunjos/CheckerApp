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
    
    var contentList = [UIColor]()
    
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
        }
        let headerNib = UINib(nibName: "ListHeaderView", bundle: nil)
        listTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
    }
    
    
    
    //MARK: Supporting Methods
    public func headerTapped(tag:Int) {
        self.listTableView.moveRow(at: IndexPath(row: 0, section: tag), to: IndexPath(row: 0, section: 0))
    }
    
    func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    //MARK: tableView methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.contentList.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier ) as! ListHeaderView
        headerView.tag = section
        headerView.tapGestureClosure = {(tag) in
            self.headerTapped(tag: tag)
        }
        headerView.bgView.backgroundColor = self.contentList[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ListTitleCell
        cell.bgView.backgroundColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 30
    }
    

}
