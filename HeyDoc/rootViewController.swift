//
//  rootViewController.swift
//  HeyDoc
//
//  Created by Mike on 2016-02-21.
//  Copyright © 2016 Mike Zaki. All rights reserved.
//

import UIKit

class rootViewController: BaseViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pageViewController = UIPageViewController()
    var pageTitles = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitles = ["Welcome to HeyDoc", "test"]
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        let startVC = self.viewControllerAtIndx(0) as TutorialViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers((viewControllers as! [UIViewController]), direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func viewControllerAtIndx (index: Int) -> TutorialViewController {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("tutorialViewController") as! TutorialViewController
        
        vc.pageIndex = index
        vc.titleIndex = self.pageTitles[index] as! String
        
        return vc
    }

//MARK: - PageViewController 
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        let vc = viewController as! TutorialViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound){
            return nil
        }
        
        --index
        
        return self.viewControllerAtIndx(index)
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! TutorialViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound){
            return nil
        }
        
        index++
        
        if (index == self.pageTitles.count){
            return nil
        }
        
        return self.viewControllerAtIndx(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count - 1
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
