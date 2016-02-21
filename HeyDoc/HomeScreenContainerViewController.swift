//
//  HomeScreenContainerViewController.swift
//  Coptic Companion
//
//  Created by Mike on 2016-02-17.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import UIKit

class HomeScreenContainerViewController: BaseViewController {

    static let liturgySegueId = "Show Liturgy"
    static let smoochSegueID = "Show Smooch"
    
    typealias swapScreenCallBack = () -> Void
    
    let swapScreenDelayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
    var currentSegueID = liturgySegueId //will eventually change to the default segue "maybe a home page ?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        // Do any additional setup after loading the view.
        
        //Segue to whatever view you want to appear first
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == HomeScreenContainerViewController.liturgySegueId {
            let liturgyViewController = segue.destinationViewController as! SubMenuViewController
            liturgyViewController.view.backgroundColor = UIColor.blueColor()
        }
        else if segue.identifier == HomeScreenContainerViewController.smoochSegueID {
            let smoochViewController = segue.destinationViewController as! SmoochViewController
            smoochViewController.view.backgroundColor = UIColor.blueColor()
        }
        
        
        //swaping between pages 
        if self.childViewControllers.count > 0 {
            self.swapFromViewController(self.childViewControllers[0], toViewController: segue.destinationViewController)
        }else{
            self.addChildViewController(segue.destinationViewController)
            let vc = segue.destinationViewController
            vc.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
            self.view.addSubview(vc.view)
            segue.destinationViewController.didMoveToParentViewController(self)
        }
    }
    
    func swapFromViewController(fromViewController: UIViewController, toViewController: UIViewController){
        fromViewController.didMoveToParentViewController(nil)
        self.addChildViewController(toViewController)
        
        self.transitionFromViewController(fromViewController, toViewController: toViewController, duration: 1.0, options: .CurveEaseInOut, animations: {}){ result in
            fromViewController.removeFromParentViewController()
            toViewController.didMoveToParentViewController(self)
        }
    }
    
    
    func showMenuItemAtIndex(index:Int, callBack: swapScreenCallBack){
        dispatch_after(swapScreenDelayTime, dispatch_get_main_queue()){
            self.performSegueWithIdentifier("Show Liturgy", sender: nil)
            callBack()
        }
    }
    
    func showPMenuItemAtIndex(index:Int, callBack: swapScreenCallBack){
        dispatch_after(swapScreenDelayTime, dispatch_get_main_queue()){
            self.performSegueWithIdentifier("Show Liturgy", sender: nil)
            callBack()
        }
    }
    
    func showSmooch(callBack: swapScreenCallBack){
        dispatch_after(swapScreenDelayTime, dispatch_get_main_queue()){
            self.performSegueWithIdentifier("Show Smooch", sender: nil)
            callBack()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
