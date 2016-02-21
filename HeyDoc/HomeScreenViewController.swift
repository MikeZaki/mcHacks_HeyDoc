//
//  HomeScreenViewController.swift
//  Coptic Companion
//
//  Created by Mike on 2016-02-13.
//  Copyright (c) 2016 Mike Zaki. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

class HomeScreenViewController : BaseViewController {
 
    //Things to add, Realm, menu
    
    //add new views at base 
    @IBOutlet weak var navigationView: BorderView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeButton: MultiLanguageButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var diagnoseQueryView: UIView!
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var diagnoseMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileTableViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var userSymptoms: UITextField!
    
    
    var containerViewController: HomeScreenContainerViewController!
    
    let realm = try!Realm()
    var notificationToken: NotificationToken?
    
    var mainMenuShown = false {
        didSet{
            if !oldValue {
                showMenu()
            }else {
                hideMenu()
            }
        }
    }
    
    var profileMenuShown = false {
        didSet{
            if !oldValue {
                showPMenu()
            }else {
                hidePMenu()
            }
        }
    }
    
    var mainMenuCollectionView:UICollectionView!
    var mainMenuBottomConstraint:NSLayoutConstraint!
    var mainMenuHeightConstraint:NSLayoutConstraint!
    var mainMenuWidthConstraint:NSLayoutConstraint!
    
    var profileMenuCollectionView:UICollectionView!
    var profileMenuBottomConstraint:NSLayoutConstraint!
    var profileMenuHeightConstraint:NSLayoutConstraint!
    var profileMenuWidthConstraint:NSLayoutConstraint!

    var mainMenuDataSource: MenuDataSource!
    var profileMenuDataSource: ProfileMenuDataSource!
    //var copticEvent = try! Realm().objects(events).sorted("position", ascending: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //synFirebaseVariables 
        notificationToken = realm.addNotificationBlock { [weak self] note, realm in
            if let strongSelf = self {
             strongSelf.updateMenu()
             strongSelf.updateSettings()
        }
       }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        realm.removeNotification(notificationToken!)
    }
    
    //MARK: - Setup 
    
    func setupUI() {
            //temporarily
        self.backgroundImageView.hidden = true
        setupNav()
        setupMainMenu()
        setupProfile()
    }
    
    func setupNav() {
        self.navigationView.layer.zPosition += 1
        self.navigationView.addBorder(edges: [.Top], colour: UIColor.lightGrayColor())
        
        self.profileButton.layer.cornerRadius = self.profileButton.frame.size.width / 2
        self.profileButton.clipsToBounds = true
        
 
        self.chatButton.layer.cornerRadius = self.chatButton.frame.size.width / 2
        self.chatButton.clipsToBounds = true
    }
    
    func setupMainMenu(){
        mainMenuDataSource = MenuDataSource()
        //pass the data source the info from the realm 
        mainMenuDataSource.didSelectMenuItem = { [weak self] index in
            if let strongSelf = self {
                strongSelf.mainMenuShown = false
                strongSelf.showMenuItemAtIndex(index)
            }
        }
        
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(300, 100)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        mainMenuCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        mainMenuCollectionView.backgroundColor = UIColor.blackColor()
        mainMenuCollectionView.alpha = 0.5
        mainMenuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mainMenuCollectionView.registerNib(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "menuCollectionViewCell")
        mainMenuCollectionView.dataSource = self.mainMenuDataSource
        mainMenuCollectionView.delegate = self.mainMenuDataSource
        
        view.addSubview(mainMenuCollectionView)
        
        let horizontalConstraint = NSLayoutConstraint(item: mainMenuCollectionView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        mainMenuBottomConstraint = NSLayoutConstraint(item: mainMenuCollectionView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        mainMenuWidthConstraint = NSLayoutConstraint(item: mainMenuCollectionView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        mainMenuHeightConstraint = NSLayoutConstraint(item: mainMenuCollectionView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 400)
        
        view.addConstraint(horizontalConstraint)
        view.addConstraint(mainMenuHeightConstraint)
        view.addConstraint(mainMenuWidthConstraint)
        view.addConstraint(mainMenuBottomConstraint)
    }
    
    func setupProfile() {
        self.profileTableView.dataSource = ProfileMenuDataSource()
        self.profileTableView.delegate = ProfileMenuDataSource()
    }
    
//MARK: - Update
    func updateMenu() {
        
        self.mainMenuCollectionView.reloadData()
        
    }
    
    func updateSettings() {
        //update change anything here
       // self.profileMenuCollectionView.reloadData()
    }
    
//MARK: - Menu 
    func showMenu(){
        self.mainMenuCollectionView.hidden = true
        self.diagnoseQueryView.hidden = false
        mainMenuBottomConstraint.constant = -(self.navigationView.frame.height+mainMenuCollectionView.frame.height)
        diagnoseMenuConstraint.constant = -(self.navigationView.frame.height+diagnoseQueryView.frame.height)
        
        let animations = {
            self.view.layoutIfNeeded()
            //maybe overlay here
        }
        
        UIView.animateWithDuration(0.5, animations: animations)
    }
    
    func hideMenu(){
        mainMenuBottomConstraint.constant = 0
        diagnoseMenuConstraint.constant = 0
        //containerView.hidden = false
        let animations = {
            self.view.layoutIfNeeded()
            //maybe overlay
        }
        
        UIView.animateWithDuration(0.5, animations: animations) { [weak self] result in
            self?.mainMenuCollectionView.hidden = true
            self?.diagnoseQueryView.hidden = true
            
        }
    }
    
//MARK: - Profile 
    func showPMenu(){
        self.profileTableView.hidden = false
        profileTableViewConstraint.constant = -(self.navigationView.frame.height+profileTableView.frame.height)
        
        
        let animations = {
            self.view.layoutIfNeeded()
        }
        
        UIView.animateWithDuration(0.5, animations: animations)
    }
    
    func hidePMenu(){
        profileTableViewConstraint.constant = 0

        let animations = {
            self.view.layoutIfNeeded()

        }
        
        UIView.animateWithDuration(0.5, animations: animations) { [weak self] result in
            self?.profileTableView.hidden = true
            
        }
    }
    
//MARK: - ContainerViews 
   
    func showMenuItemAtIndex (index:Int) {
        self.containerViewController.showMenuItemAtIndex(index){
          self.containerViewController.navigationController?.popToRootViewControllerAnimated(false)
        }
    }
    
    func showPMenuItemAtIndex (index:Int) {
        self.containerViewController.showPMenuItemAtIndex(index){
            self.containerViewController.navigationController?.popToRootViewControllerAnimated(false)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMainMenu" {
            let newController = segue.destinationViewController as! UINavigationController
            self.containerViewController = newController.topViewController as! HomeScreenContainerViewController
        }
    }
    
    
    //onOverlayTapped 
    //onSettingsTapped
    //onQuickMenuPressed 
    
    @IBAction func onMenuButtonPressed(sender: MultiLanguageButton) {
        if self.profileMenuShown {
            profileMenuShown = false
        }
        self.mainMenuShown = !mainMenuShown
    }
    
    @IBAction func onProfileButtonPressed(sender: UIButton) {
        if self.mainMenuShown {
            mainMenuShown = false
        }
        self.profileMenuShown = !profileMenuShown
    }
    
    @IBAction func onChatButtonPressed(sender: UIButton) {
        self.containerViewController.showSmooch{
            self.containerViewController.navigationController?.popToRootViewControllerAnimated(false)
        }
    }

    @IBAction func onDiagnoseButtonPressed(sender: UIButton) {
        if userSymptoms.text != ""
        {
            let wordsArray = []
            let textString = userSymptoms.text
            DiagnosisManager().evaluateQuerry(DiagnosisManager().populateDiagnosticQuery(textString!, intoArray: wordsArray as! [String]))
            let smoochViewController = SmoochViewController()
            let userId = SKTUser.currentUser().smoochId
            print(userId)
            Smooch.showConversationFromViewController(smoochViewController)
            mainMenuShown = !mainMenuShown
        }else{
            //alert
        }
    }
    
}
