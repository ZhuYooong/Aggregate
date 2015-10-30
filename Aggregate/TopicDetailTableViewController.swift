//
//  TopicDetailTableViewController.swift
//  Aggregate
//
//  Created by MAC on 15/10/30.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class TopicDetailTableViewController: UITableViewController {
    @IBOutlet weak var headerTitleLable: UILabel!
    @IBOutlet weak var headerContentLable: UILabel!
    @IBOutlet weak var headerMemberButton: UIButton!
    @IBOutlet weak var headerRepliesLable: UILabel!
    @IBOutlet weak var headerMemberImageView: UIImageView!
    @IBOutlet weak var headerMemberNameLable: UILabel!
    @IBOutlet weak var headerTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var headerContentHeight: NSLayoutConstraint!
    var topicId: String?
    var pageNum = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    //MARK:-初始化数据
    func initData() {
        if let topicId = topicId {
            TopicDetailViewModel.shareTopicDetailViewModel().findTopicsInfo(topicId) {
                (contentArray) in
                
            }
            TopicDetailViewModel.shareTopicDetailViewModel().findReplies(topicId, page: "\(pageNum)") {
                (contentArray) in
                
            }
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
