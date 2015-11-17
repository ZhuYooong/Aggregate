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
    var contentArray = NSArray()
     override func viewDidLoad() {
        super.viewDidLoad()
        initItem()
        initData()
    }
    //MARK:初始化数据
    func initData() {
        let bundlePath = NSBundle.mainBundle().pathForResource("AggregateList", ofType: "plist")
        if let resultArray = NSArray(contentsOfFile: bundlePath!) {
            contentArray = resultArray
            collectionView?.reloadData()
        }
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
        if indexPath.row > 0 {
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! AddMenuCollectionViewCell
            if cell.addMenuTitleLable.backgroundColor == UIColor.lightGrayColor() {
                
            }else {
                
            }
        }
    }
}