//
//  AddMenuCollectionViewController.swift
//  Aggregate
//
//  Created by MAC on 15/11/16.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

private let reuseIdentifier = "AddMenuCell"

class AddMenuCollectionViewController: UICollectionViewController {
    var backLogIn = backToLogInFunc?()
    let bundlePath = NSBundle.mainBundle().pathForResource("AggregateList", ofType: "plist")
    var contentArray: NSMutableArray {
        set {
        }get {
            if let resultArray = NSMutableArray(contentsOfFile: bundlePath!) {
                return resultArray
            }else {
                return NSMutableArray()
            }
        }
    }
     override func viewDidLoad() {
        super.viewDidLoad()
        initItem()
    }
    //MARK:初始化控件
    func initItem() {
        let crossBtn = UIButton(frame: CGRectMake(0,0,30,30))
        crossBtn.addTarget(self, action: "crossButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        crossBtn.setImage(UIImage(named: "right_icon_services"), forState: UIControlState.Normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: crossBtn)
    }
    func crossButtonClick(sender: UIButton) {
        backLogIn!()
    }
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentArray.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AddMenuCollectionViewCell
        if contentArray.count > indexPath.row {
            if let state = contentArray[indexPath.row]["state"] as? String where state == "1" {
                cell.addMenuTitleLable.backgroundColor = UIColor.lightGrayColor()
            }else {
                cell.addMenuTitleLable.backgroundColor = UIColor.whiteColor()
            }
            if let name = contentArray[indexPath.row]["name"] as? String where name == "V2EX" {
                cell.addMenuTitleLable.text = name
                cell.addMenuImageView.image = UIImage(named: "V2EX_icon")
            }else if let name = contentArray[indexPath.row]["name"] as? String where name == "Sina" {
                cell.addMenuTitleLable.text = name
                cell.addMenuImageView.image = UIImage(named: "sina_icon")
            }
        }
        return cell
    }
    // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row > 0 && contentArray.count > indexPath.row {
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! AddMenuCollectionViewCell
            var messageStr = ""
            var okAction = UIAlertAction?()
            let contentDic = contentArray[indexPath.row] as! NSMutableDictionary
            contentDic.setValue("1", forKey: "state")
            if cell.addMenuTitleLable.backgroundColor == UIColor.lightGrayColor() {
                messageStr = "你确定要删除吗？"
                okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                    contentDic.setValue("0", forKey: "state")
                    contentDic.writeToFile(self.bundlePath!, atomically: false)
                    self.collectionView!.reloadData()
                })
            }else {
                messageStr = "你确定要添加吗？"
                okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                    contentDic.setValue("1", forKey: "state")
                    contentDic.writeToFile(self.bundlePath!, atomically: false)
                    self.collectionView!.reloadData()
                })
            }
            let addAlert = UIAlertController(title: "温馨提示", message: messageStr, preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
            addAlert.addAction(cancelAction)
            if let okAction = okAction {
                addAlert.addAction(okAction)
            }
            presentViewController(addAlert, animated: true, completion: nil)
        }
    }
}