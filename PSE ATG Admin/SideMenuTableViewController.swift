//
//  SideMenuTableViewController.swift
//  PSE ATG Admin
//
//  Created by TAWEERAT CHAIMAN on 1/3/2561 BE.
//  Copyright © 2561 TAWEERAT CHAIMAN. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    var menuItems = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initItems()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func initItems() {
        menuItems.append("Dashboard")
        menuItems.append("Sites")
        menuItems.append("Users")
        menuItems.append("Sign out")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "SideMenuTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SideMenuTableViewCell else {
            fatalError("The dequeue cell is not an instance of SideMenuTableViewCell")
        }
        
        let item = menuItems[indexPath.row]
        
        cell.itemLabel.text = item

        return cell
    }
    
    private func changeViewController(to identifier: String) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(viewController!, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            changeViewController(to: "DashboardViewController")
        case 1:
            print("sites")
        case 2:
            changeViewController(to: "UsersViewController")
        case 3:
            UserController.signout()
            changeViewController(to: "SigninViewController")
        default:
            break
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
