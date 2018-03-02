//
//  UsersViewController.swift
//  PSE ATG Admin
//
//  Created by TAWEERAT CHAIMAN on 1/3/2561 BE.
//  Copyright © 2561 TAWEERAT CHAIMAN. All rights reserved.
//

import UIKit
import SideMenu

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let apiManager = ApiManager()
    let FETCH_USERS_URL = "https://atg.padungsilpa.group/_api/users"
    let cellIdentifier = "UsersTableViewCell"
    var users = [User]()
    private let refreshControl = UIRefreshControl()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UsersTableViewCell else {
            fatalError("The dequeue cell is not instance of UsersTableViewCell")
        }
        
        let user = users[indexPath.row]
        cell.nameLabel.text = user.name
        cell.emailLabel.text = user.email
        if user.active {
            cell.activeLabel.backgroundColor = #colorLiteral(red: 0.2779378555, green: 0.795073688, blue: 0.4190243913, alpha: 1)
        }else {
            cell.activeLabel.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        
        if user.verified {
            cell.verifiedLabel.backgroundColor = #colorLiteral(red: 0.2779378555, green: 0.795073688, blue: 0.4190243913, alpha: 1)
        }else {
            cell.verifiedLabel.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setupTableView()
        loadData(){_ in }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //reload table when user pressed back from previous ViewController
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshUserData(_:)), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.3270013332, green: 0.795073688, blue: 0.7949342728, alpha: 1)
        let attributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3270013332, green: 0.795073688, blue: 0.7949342728, alpha: 1)]
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching users ...", attributes: attributes)
    }
    
    private func loadData(completionHandler: @escaping (_ completed: Bool) -> Void) {
        var users = [User]()
        let headers = [
            "Authorization": UserController.getToken()
        ]
        apiManager.fetch(url: FETCH_USERS_URL, header: headers, body: nil, method: "GET") {
            response -> Void in
            if response != nil {
                if response!["success"] as! Bool {
                    var data = response!["data"] as! [[String: Any]]
                    data = data.reversed()
                    for item in data {
                        let id = item["id"] as! Int
                        let name = item["name"] as! String
                        let email = item["email"] as! String
                        let privilege = item["privilege"] as! Int
                        let tel = item["tel"] as! String
                        let active = item["active"] as! Bool
                        let verified = item["verified"] as! Bool
                        let user = User(id: id, name: name, email: email, privilege: privilege, tel: tel, active: active, verified: verified)
                        users.append(user!)
                    }
                    
                    self.users.removeAll(keepingCapacity: false)
                    self.users += users
                    
                    self.tableView.reloadData()
                    
                    completionHandler(true)
                }else {
                    fatalError(response!["error"] as! String)
                }
            }
        }
    }
    
    @objc private func refreshUserData(_ sender: Any) {
        self.loadData() {
            completed -> Void in
            if completed {
                self.refreshControl.endRefreshing()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Mark: prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "ShowUserDetail":
            guard let userViewController = segue.destination as? UserViewController else {
                fatalError("Destination controller is not instance of UserViewController")
                }
            guard let selectedUserCell = sender as? UsersTableViewCell else {
                fatalError("Selected cell is not instance of UsersTableViewCell")
            }
            
            let indexPath = tableView.indexPath(for: selectedUserCell)!
            userViewController.user = users[indexPath.row]
        default:
            break
        }
        
    }
    
    //Mark: Unwind action
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? UserViewController, let user = sourceViewController.user {
            // check that any row is being selected or not. If it is that means user tapped one of the table view cell to edit user.
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // update the exising user
                users[selectedIndexPath.row] = user
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            }
        }
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
