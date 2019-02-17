//
//  FollowersViewController.swift
//  mastodon
//
//  Created by Shihab Mehboob on 24/09/2018.
//  Copyright © 2018 Shihab Mehboob. All rights reserved.
//

import Foundation
import UIKit
import SJFluidSegmentedControl
import StatusAlert

class FollowersViewController: UIViewController, SJFluidSegmentedControlDataSource, SJFluidSegmentedControlDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var ai = NVActivityIndicatorView(frame: CGRect(x:0,y:0,width:0,height:0), type: .circleStrokeSpin, color: Colours.tabSelected)
    var segmentedControl: SJFluidSegmentedControl!
    var tableView = UITableView()
    var currentIndex = 0
    var profileStatus = ""
    var statusFollows: [Account] = []
    var statusFollowers: [Account] = []
    var doOnce = false
    var doOnce2 = false
    
    
    @objc func load() {
        DispatchQueue.main.async {
            self.loadLoadLoad()
        }
    }
    @objc func search() {
        let controller = DetailViewController()
        controller.mainStatus.append(StoreStruct.statusSearch[StoreStruct.searchIndex])
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //self.ai.startAnimating()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if (UserDefaults.standard.object(forKey: "segsize") == nil) || (UserDefaults.standard.object(forKey: "segsize") as! Int == 0) {} else {
            springWithDelay(duration: 0.4, delay: 0, animations: {
                self.segmentedControl.alpha = 0
            })
        }
    }
    
    @objc func changeSeg() {
        
        
        var tabHeight = Int(UITabBarController().tabBar.frame.size.height) + Int(34)
        var offset = 88
        var newoff = 45
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2688:
                offset = 88
                newoff = 45
            case 2436, 1792:
                offset = 88
                newoff = 45
            default:
                offset = 64
                tabHeight = Int(UITabBarController().tabBar.frame.size.height)
                newoff = 24
            }
        }
        
        if (UserDefaults.standard.object(forKey: "segsize") == nil) || (UserDefaults.standard.object(forKey: "segsize") as! Int == 0) {
            segmentedControl = SJFluidSegmentedControl(frame: CGRect(x: CGFloat(20), y: CGFloat(offset + 5), width: CGFloat(self.view.bounds.width - 40), height: CGFloat(40)))
            segmentedControl.dataSource = self
            if (UserDefaults.standard.object(forKey: "segstyle") == nil) || (UserDefaults.standard.object(forKey: "segstyle") as! Int == 0) {
                segmentedControl.shapeStyle = .roundedRect
            } else {
                segmentedControl.shapeStyle = .liquid
            }
            segmentedControl.textFont = .systemFont(ofSize: 16, weight: .heavy)
            segmentedControl.cornerRadius = 12
            segmentedControl.shadowsEnabled = false
            segmentedControl.transitionStyle = .slide
            segmentedControl.delegate = self
            view.addSubview(segmentedControl)
            
            self.tableView.register(FollowersCell.self, forCellReuseIdentifier: "cellf")
            self.tableView.frame = CGRect(x: 0, y: Int(offset + 60), width: Int(self.view.bounds.width), height: Int(self.view.bounds.height) - offset - tabHeight - 65)
            self.tableView.alpha = 1
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.separatorStyle = .singleLine
            self.tableView.backgroundColor = Colours.white
            self.tableView.separatorColor = Colours.cellQuote
            self.tableView.layer.masksToBounds = true
            self.tableView.estimatedRowHeight = 89
            self.tableView.rowHeight = UITableView.automaticDimension
            self.view.addSubview(self.tableView)
        } else {
            if UIApplication.shared.isSplitOrSlideOver {
                segmentedControl = SJFluidSegmentedControl(frame: CGRect(x: CGFloat(self.view.bounds.width/2 - 120), y: CGFloat(30), width: CGFloat(240), height: CGFloat(40)))
            } else {
                segmentedControl = SJFluidSegmentedControl(frame: CGRect(x: CGFloat(self.view.bounds.width/2 - 120), y: CGFloat(newoff), width: CGFloat(240), height: CGFloat(40)))
            }
            segmentedControl.dataSource = self
            if (UserDefaults.standard.object(forKey: "segstyle") == nil) || (UserDefaults.standard.object(forKey: "segstyle") as! Int == 0) {
                segmentedControl.shapeStyle = .roundedRect
            } else {
                segmentedControl.shapeStyle = .liquid
            }
            segmentedControl.textFont = .systemFont(ofSize: 16, weight: .heavy)
            segmentedControl.cornerRadius = 12
            segmentedControl.shadowsEnabled = false
            segmentedControl.transitionStyle = .slide
            segmentedControl.delegate = self
            self.navigationController?.view.addSubview(segmentedControl)
            
            self.tableView.register(FollowersCell.self, forCellReuseIdentifier: "cellf")
            self.tableView.frame = CGRect(x: 0, y: Int(offset + 10), width: Int(self.view.bounds.width), height: Int(self.view.bounds.height) - offset - tabHeight - 15)
            self.tableView.alpha = 1
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.separatorStyle = .singleLine
            self.tableView.backgroundColor = Colours.white
            self.tableView.separatorColor = Colours.cellQuote
            self.tableView.layer.masksToBounds = true
            self.tableView.estimatedRowHeight = 89
            self.tableView.rowHeight = UITableView.automaticDimension
            self.view.addSubview(self.tableView)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.search), name: NSNotification.Name(rawValue: "search"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.load), name: NSNotification.Name(rawValue: "load"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeSeg), name: NSNotification.Name(rawValue: "changeSeg"), object: nil)
        
        self.ai.frame = CGRect(x: self.view.bounds.width/2 - 20, y: self.view.bounds.height/2, width: 40, height: 40)
        self.view.backgroundColor = Colours.white
        
        var tabHeight = Int(UITabBarController().tabBar.frame.size.height) + Int(34)
        var offset = 88
        var newoff = 45
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2688:
                offset = 88
                newoff = 45
            case 2436, 1792:
                offset = 88
                newoff = 45
            default:
                offset = 64
                tabHeight = Int(UITabBarController().tabBar.frame.size.height)
                newoff = 24
            }
        }
        
        if (UserDefaults.standard.object(forKey: "segsize") == nil) || (UserDefaults.standard.object(forKey: "segsize") as! Int == 0) {
            segmentedControl = SJFluidSegmentedControl(frame: CGRect(x: CGFloat(20), y: CGFloat(offset + 5), width: CGFloat(self.view.bounds.width - 40), height: CGFloat(40)))
            segmentedControl.dataSource = self
            if (UserDefaults.standard.object(forKey: "segstyle") == nil) || (UserDefaults.standard.object(forKey: "segstyle") as! Int == 0) {
                segmentedControl.shapeStyle = .roundedRect
            } else {
                segmentedControl.shapeStyle = .liquid
            }
            segmentedControl.textFont = .systemFont(ofSize: 16, weight: .heavy)
            segmentedControl.cornerRadius = 12
            segmentedControl.shadowsEnabled = false
            segmentedControl.transitionStyle = .slide
            segmentedControl.delegate = self
            view.addSubview(segmentedControl)
            
            self.tableView.register(FollowersCell.self, forCellReuseIdentifier: "cellf")
            self.tableView.frame = CGRect(x: 0, y: Int(offset + 60), width: Int(self.view.bounds.width), height: Int(self.view.bounds.height) - offset - tabHeight - 65)
            self.tableView.alpha = 1
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.separatorStyle = .singleLine
            self.tableView.backgroundColor = Colours.white
            self.tableView.separatorColor = Colours.cellQuote
            self.tableView.layer.masksToBounds = true
            self.tableView.estimatedRowHeight = 89
            self.tableView.rowHeight = UITableView.automaticDimension
            self.view.addSubview(self.tableView)
        } else {
            if UIApplication.shared.isSplitOrSlideOver {
                segmentedControl = SJFluidSegmentedControl(frame: CGRect(x: CGFloat(self.view.bounds.width/2 - 120), y: CGFloat(30), width: CGFloat(240), height: CGFloat(40)))
            } else {
                segmentedControl = SJFluidSegmentedControl(frame: CGRect(x: CGFloat(self.view.bounds.width/2 - 120), y: CGFloat(newoff), width: CGFloat(240), height: CGFloat(40)))
            }
            segmentedControl.dataSource = self
            if (UserDefaults.standard.object(forKey: "segstyle") == nil) || (UserDefaults.standard.object(forKey: "segstyle") as! Int == 0) {
                segmentedControl.shapeStyle = .roundedRect
            } else {
                segmentedControl.shapeStyle = .liquid
            }
            segmentedControl.textFont = .systemFont(ofSize: 16, weight: .heavy)
            segmentedControl.cornerRadius = 12
            segmentedControl.shadowsEnabled = false
            segmentedControl.transitionStyle = .slide
            segmentedControl.delegate = self
            self.navigationController?.view.addSubview(segmentedControl)
            
            self.tableView.register(FollowersCell.self, forCellReuseIdentifier: "cellf")
            self.tableView.frame = CGRect(x: 0, y: Int(offset + 10), width: Int(self.view.bounds.width), height: Int(self.view.bounds.height) - offset - tabHeight - 15)
            self.tableView.alpha = 1
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.separatorStyle = .singleLine
            self.tableView.backgroundColor = Colours.white
            self.tableView.separatorColor = Colours.cellQuote
            self.tableView.layer.masksToBounds = true
            self.tableView.estimatedRowHeight = 89
            self.tableView.rowHeight = UITableView.automaticDimension
            self.view.addSubview(self.tableView)
        }
        
        
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        switch (deviceIdiom) {
        case .phone:
            print("nothing")
        case .pad:
            self.title = "Follows"
        default:
            print("nothing")
        }
        
        self.loadLoadLoad()
        
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("newsize")
        print(size)
        
        super.viewWillTransition(to: size, with: coordinator)
//        coordinator.animate(alongsideTransition: nil, completion: {
//            _ in
            self.tableView.frame = CGRect(x: 0, y: Int(0), width: Int(size.width), height: Int(size.height))
//        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        switch (deviceIdiom) {
        case .phone:
            print("nothing")
        case .pad:
            self.tableView.frame = CGRect(x: 0, y: Int(0), width: Int(self.view.frame.width), height: Int(self.view.frame.height))
        default:
            print("nothing")
        }
        
        springWithDelay(duration: 0.4, delay: 0, animations: {
            self.segmentedControl.alpha = 1
        })
        if StoreStruct.historyBool {
            self.changeSeg()
        }
        
        StoreStruct.historyBool = false
        
        let request2 = Accounts.followers(id: self.profileStatus)
        StoreStruct.client.run(request2) { (statuses) in
            if let stat = (statuses.value) {
                self.statusFollowers = stat
                self.statusFollows = self.statusFollows.removeDuplicates()
                DispatchQueue.main.async {
                        self.tableView.reloadData()
                }
            }
        }
        StoreStruct.currentPage = 90
    }
    
    
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        return 2
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, titleForSegmentAtIndex index: Int) -> String? {
        if (UserDefaults.standard.object(forKey: "hapticToggle") == nil) || (UserDefaults.standard.object(forKey: "hapticToggle") as! Int == 0) {
            let selection = UISelectionFeedbackGenerator()
            selection.selectionChanged()
        }
        if index == 0 {
            return "Follows".localized
        } else {
            return "Followers".localized
        }
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
        if (UserDefaults.standard.object(forKey: "seghue1") == nil) || (UserDefaults.standard.object(forKey: "seghue1") as! Int == 0) {
            return [Colours.tabSelected, Colours.tabSelected]
        } else {
            return [Colours.grayLight2, Colours.grayLight2]
        }
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
        if (UserDefaults.standard.object(forKey: "seghue1") == nil) || (UserDefaults.standard.object(forKey: "seghue1") as! Int == 0) {
            return [Colours.tabSelected, Colours.tabSelected]
        } else {
            return [Colours.grayLight2, Colours.grayLight2]
        }
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
        if toIndex == 0 {
            self.currentIndex = 0
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        if toIndex == 1 {
            self.currentIndex = 1
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // Table stuff
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.currentIndex == 0 {
            return self.statusFollows.count
        } else {
            return self.statusFollowers.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.currentIndex == 0 {
            
            if self.statusFollows.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellf", for: indexPath) as! FollowersCell
                cell.backgroundColor = Colours.white
                let bgColorView = UIView()
                bgColorView.backgroundColor = Colours.white
                cell.selectedBackgroundView = bgColorView
                return cell
            } else {
            
            if indexPath.row == self.statusFollows.count - 6 {
                self.fetchFollows()
            }
            if indexPath.row < 7 && self.doOnce == false {
                self.doOnce = true
                self.fetchFollows()
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellf", for: indexPath) as! FollowersCell
            cell.configure(self.statusFollows[indexPath.row])
            cell.profileImageView.tag = indexPath.row
            cell.profileImageView.addTarget(self, action: #selector(self.didTouchProfile), for: .touchUpInside)
            cell.backgroundColor = Colours.white
            cell.userName.textColor = Colours.black
            cell.userTag.textColor = Colours.black
            cell.toot.textColor = Colours.black.withAlphaComponent(0.6)
            let bgColorView = UIView()
            bgColorView.backgroundColor = Colours.white
            cell.selectedBackgroundView = bgColorView
            return cell
            }
        } else {
            
            if self.statusFollowers.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellf", for: indexPath) as! FollowersCell
                cell.backgroundColor = Colours.white
                let bgColorView = UIView()
                bgColorView.backgroundColor = Colours.white
                cell.selectedBackgroundView = bgColorView
                return cell
            } else {
            
            if indexPath.row == self.statusFollowers.count - 6 {
                self.fetchFollowers()
            }
            if indexPath.row < 7 && self.doOnce2 == false {
                self.doOnce2 = true
                self.fetchFollowers()
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellf", for: indexPath) as! FollowersCell
            cell.configure(self.statusFollowers[indexPath.row])
            cell.profileImageView.tag = indexPath.row
            cell.profileImageView.addTarget(self, action: #selector(self.didTouchProfile), for: .touchUpInside)
            cell.backgroundColor = Colours.white
            cell.userName.textColor = Colours.black
            cell.userTag.textColor = Colours.black
            cell.toot.textColor = Colours.black.withAlphaComponent(0.6)
            let bgColorView = UIView()
            bgColorView.backgroundColor = Colours.white
            cell.selectedBackgroundView = bgColorView
            return cell
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = ThirdViewController()
        controller.fromOtherUser = true
        if self.currentIndex == 0 {
            controller.userIDtoUse = self.statusFollows[indexPath.row].id
        } else {
            controller.userIDtoUse = self.statusFollowers[indexPath.row].id
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func didTouchProfile(sender: UIButton) {
        if (UserDefaults.standard.object(forKey: "hapticToggle") == nil) || (UserDefaults.standard.object(forKey: "hapticToggle") as! Int == 0) {
        let selection = UISelectionFeedbackGenerator()
        selection.selectionChanged()
        }
    }
    
    var lastThing = ""
    func fetchFollows() {
        let request = Accounts.following(id: self.profileStatus, range: .max(id: self.statusFollows.last?.id ?? "", limit: nil))
        StoreStruct.client.run(request) { (statuses) in
            if let stat = (statuses.value) {
                
                if stat.isEmpty || self.lastThing == stat.first?.id ?? "" {} else {
                    self.lastThing = stat.first?.id ?? ""
                self.statusFollows = self.statusFollows + stat
                    self.statusFollows = self.statusFollows.removeDuplicates()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                }
            }
        }
    }
    
    var lastThing2 = ""
    func fetchFollowers() {
        let request = Accounts.followers(id: self.profileStatus, range: .max(id: self.statusFollows.last?.id ?? "", limit: nil))
        StoreStruct.client.run(request) { (statuses) in
            if let stat = (statuses.value) {
                
                if stat.isEmpty || self.lastThing2 == stat.first?.id ?? "" {} else {
                    self.lastThing2 = stat.first?.id ?? ""
                self.statusFollows = self.statusFollows + stat
                    self.statusFollows = self.statusFollows.removeDuplicates()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                }
            }
        }
    }
    
    
    
    
    func loadLoadLoad() {
        Theme.setThemeGlobalsFromUserSettings()
        
        self.view.backgroundColor = Colours.white
        self.tableView.backgroundColor = Colours.white
        self.tableView.separatorColor = Colours.cellQuote
        self.tableView.reloadData()
        self.tableView.reloadInputViews()
        //        var customStyle = VolumeBarStyle.likeInstagram
        //        customStyle.trackTintColor = Colours.cellQuote
        //        customStyle.progressTintColor = Colours.grayDark
        //        customStyle.backgroundColor = Colours.cellNorm
        //        volumeBar.style = customStyle
        //        volumeBar.start()
        //
        //        self.missingView.image = UIImage(named: "missing")?.maskWithColor(color: Colours.tabUnselected)
        //
        //        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Colours.grayDark]
        //        self.collectionView.backgroundColor = Colours.white
        //        self.removeTabbarItemsText()
    }
    
    
}
