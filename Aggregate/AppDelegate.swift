//
//  AppDelegate.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/8.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //MARK:- 变量
    var drawersStoryboard: UIStoryboard?
    var drawerAnimator: JVFloatingDrawerSpringAnimator?
    var drawerViewController: MainDrawViewController?
    //主页
    var homeViewController: UIViewController?
    //菜单页
    var menuViewController: UIViewController?
    var window: UIWindow?
    
    //MARK:- 生命周期
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.backgroundColor = UIColor.whiteColor()
        //MARK:菜单栏
        initItem()
        configureDrawerViewController()
        //MARK:分享
        ShareSDK.registerApp("c00530c678b8", activePlatforms: [SSDKPlatformType.TypeSinaWeibo.rawValue, SSDKPlatformType.TypeTencentWeibo.rawValue, SSDKPlatformType.TypeWechat.rawValue, SSDKPlatformType.TypeQQ.rawValue], onImport: { (platform: SSDKPlatformType) -> Void in
            switch platform {
            case SSDKPlatformType.TypeWechat:
                ShareSDKConnector.connectWeChat(WXApi.classForCoder())
            case SSDKPlatformType.TypeQQ:
                ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
            default:
                break
            }
            }, onConfiguration: {(platform: SSDKPlatformType, appInfo: NSMutableDictionary!) -> Void in
                switch platform {
                case SSDKPlatformType.TypeSinaWeibo:
                    appInfo.SSDKSetupSinaWeiboByAppKey("", appSecret: "", redirectUri: "http://www.sharesdk.cn", authType: SSDKAuthTypeBoth)
                case SSDKPlatformType.TypeTencentWeibo:
                    appInfo.SSDKSetupTencentWeiboByAppKey("", appSecret: "", redirectUri: "http://www.sharesdk.cn")
                case SSDKPlatformType.TypeWechat:
                    appInfo.SSDKSetupWeChatByAppId("", appSecret: "")
                default:
                    break
                }
        })
        window!.rootViewController = drawerViewController
        window!.makeKeyAndVisible()
        return true
    }
    func initItem() {
        drawersStoryboard = UIStoryboard(name: "Main", bundle: nil)
        drawerAnimator = JVFloatingDrawerSpringAnimator()
        drawerViewController = drawersStoryboard?.instantiateViewControllerWithIdentifier("drawID") as? MainDrawViewController
        homeViewController = drawersStoryboard?.instantiateViewControllerWithIdentifier("homeID")
        menuViewController = UIStoryboard(name: "Menu", bundle: nil).instantiateViewControllerWithIdentifier("MenuID")
    }
    func configureDrawerViewController() {
        drawerViewController!.leftViewController = menuViewController
        drawerViewController!.centerViewController = homeViewController
        drawerViewController!.animator = drawerAnimator
    }
    func applicationWillResignActive(application: UIApplication) {
    }
    func applicationDidEnterBackground(application: UIApplication) {
    }
    func applicationWillEnterForeground(application: UIApplication) {
    }
    func applicationDidBecomeActive(application: UIApplication) {
    }
    func applicationWillTerminate(application: UIApplication) {
        self.saveContext()
    }
    // MARK: - Core Data stack
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ZY.Aggregate" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Aggregate", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    // MARK: - Core Data Saving support
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}
