//
//  MasterViewController.swift
//  CoolNewsFeed
//
//  Created by Thiago Heitling on 2016-02-16.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

enum NewsCatgory:String {
    case World = "World"
    case Americas = "Americas"
    case Europe = "Europe"
    case MiddleEast = "Middle East"
    case Africa = "Africa"
    case Asia = "Asia"
    
    func textColor() -> UIColor {
        switch self {
        case .World:
            return UIColor .redColor()
        case .Americas:
            return UIColor .greenColor()
        case .Europe:
            return UIColor .yellowColor()
        case .MiddleEast:
            return UIColor .orangeColor()
        case .Africa:
            return UIColor .purpleColor()
        case .Asia:
            return UIColor .blueColor()
        }
    }
}

struct NewsItem {
    var category: NewsCatgory
    var headline: String
}

class MasterViewController: UITableViewController {
    
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    
    let kTableHeaderHeight: CGFloat = 200.0
    
    var newsItems = [NewsItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        let formattedDate = dateFormatter.stringFromDate(currentDate)
        currentDateLabel.text = formattedDate
        
        tableView.estimatedRowHeight = 10.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        let item1 = NewsItem(category: .World, headline: "Climate change protests, divestments meet fossil fuels realities")
        let item2 = NewsItem(category: .Africa, headline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim")
        let item3 = NewsItem(category: .Americas, headline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria")
        let item4 = NewsItem(category: .Asia, headline: "Despite UN ruling, Japan seeks backing for whale hunting")
        let item5 = NewsItem(category: .World, headline: "South Africa in $40 billion deal for Russian nuclear reactors")
        let item6 = NewsItem(category: .Europe, headline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime")
        let item7 = NewsItem(category: .MiddleEast, headline: "Airstrikes boost Islamic State, FBI director warns more hostages possible")
        let item8 = NewsItem(category: .Europe, headline: "One million babies' created by EU student exchanges")
        
        newsItems = [item1, item2, item3, item4, item5, item6, item7, item8]
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        headerView.clipsToBounds = true
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        updateHeaderView()
    }

    override func viewWillAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = newsItems[indexPath.row]
                let controller = segue.destinationViewController as! DetailViewController
                controller.detailItem = object.category.rawValue
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CustomTableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? CustomTableViewCell
        let newsObject = newsItems[indexPath.row]
        cell!.categoryLabel.text = newsObject.category.rawValue
        cell!.categoryLabel.textColor = newsObject.category.textColor()
        cell!.headlineLabel.text = newsObject.headline
        return cell!
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            newsItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func updateHeaderView(){
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerRect
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
}

