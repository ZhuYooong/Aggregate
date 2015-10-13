//
//  HomeViewController.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/9.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var drawerAnimator: JVFloatingDrawerSpringAnimator?
    let hamburgerBtn = HamburgerButton()//显示节点按钮
    let buttonItem = Int(UIScreen.mainScreen().bounds.size.width / 60)//每行显示的节点数
    let nodeListNumber = 17
    @IBOutlet weak var nodeHeight: NSLayoutConstraint!//下边的高度
    @IBOutlet weak var nodeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutMenuController()
        nodeCollectionView.registerClass(NodeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "nodeCell")
    }
    //MARK:- 与菜单界面相关的
    func aboutMenuController() {
        drawerAnimator = (UIApplication.sharedApplication().delegate as! AppDelegate).drawerAnimator
        configureAnimator()
        toMenuViewController()
    }
    func configureAnimator() {
        drawerAnimator?.animationDuration = 1
        drawerAnimator?.animationDelay = 0.00
        drawerAnimator?.initialSpringVelocity = 1
    }
    func toMenuViewController() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(swipeGesture)
    }
    func handleSwipeGesture(sender: UISwipeGestureRecognizer){
        if (sender.direction == UISwipeGestureRecognizerDirection.Right) {
            (UIApplication.sharedApplication().delegate as! AppDelegate).drawerViewController!.toggleDrawerWithSide(JVFloatingDrawerSide.Left, animated: true, completion: nil)
        }
    }
}
//MARK:- 节点列表代理
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nodeListNumber
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("nodeCell", forIndexPath: indexPath) as! NodeCollectionViewCell
        if (indexPath.row == buttonItem - 1) {
            hamburgerBtn.frame = CGRectMake(10, -8, 60, 40)
            hamburgerBtn.addTarget(self, action: "showOrHideNode:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.contentView.addSubview(hamburgerBtn)
        }else if (indexPath.row == nodeListNumber - 1) {
            if (cell.contentView.subviews.count == 0) {
                let moreLable = UILabel(frame: CGRectMake(0, 0, 60, 40))
                moreLable.textAlignment = NSTextAlignment.Center
                moreLable.font = UIFont.systemFontOfSize(12)
                moreLable.text = "全部节点……"
                cell.contentView.addSubview(moreLable)
            }
        }else {
            if (cell.contentView.subviews.count == 0) {
                let nodeLable = UILabel(frame: CGRectMake(0, 0, 60, 40))
                nodeLable.textAlignment = NSTextAlignment.Center
                nodeLable.font = UIFont.systemFontOfSize(12)
                nodeLable.text = "潇洒的撒旦"
                cell.contentView.addSubview(nodeLable)
            }
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == buttonItem - 1) {
        }else if (indexPath.row == nodeListNumber - 1) {//跳转全部节点
            
        }else {
            
        }
    }
    func showOrHideNode(sender: HamburgerButton) {
        sender.showMenu = !sender.showMenu
        if (sender.showMenu) {
            UIView.animateWithDuration(0.6, animations: {
                () in
                let count = CGFloat(self.nodeListNumber) / CGFloat(self.buttonItem)
                self.nodeHeight.constant = 40 * ceil(count)
                self.view.layoutIfNeeded()
            })
        }else{
            UIView.animateWithDuration(0.6, animations: {
                () in
                self.nodeHeight.constant = 40
                self.view.layoutIfNeeded()
            })
        }
    }
}