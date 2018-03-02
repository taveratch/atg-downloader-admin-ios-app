//
//  DashboardViewController.swift
//  PSE ATG Admin
//
//  Created by TAWEERAT CHAIMAN on 1/3/2561 BE.
//  Copyright © 2561 TAWEERAT CHAIMAN. All rights reserved.
//

import UIKit
import SideMenu

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUserData()
        self.initSideMenu()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func initSideMenu() {
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.default.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuAnimationBackgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        SideMenuManager.default.menuAlwaysAnimate = true
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func initUserData() {
        let user = UserController.getCurrentUser()
        nameLabel.text = (user!["name"] as! String)
        emailLabel.text = (user!["email"] as! String)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
