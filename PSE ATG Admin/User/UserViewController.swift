//
//  UserViewController.swift
//  PSE ATG Admin
//
//  Created by TAWEERAT CHAIMAN on 1/3/2561 BE.
//  Copyright © 2561 TAWEERAT CHAIMAN. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var user: User?
    let api = Api()
    
    @IBOutlet weak var activateButton: RoundBorderButton!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var verifiedLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: Setup methods
    private func setupNavigation() {
        self.navigationItem.title = "Detail"
    }
    
    private func setupUI() {
        if (user != nil) {
            nameLabel.text = user!.name
            phoneLabel.text = user!.tel
            emailLabel.text = user!.email
            if user!.verified {
                verifiedLabel.text = "Email Verified"
                verifiedLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else {
                verifiedLabel.text = "Email Unverified"
                verifiedLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
            if user!.active {
                activeLabel.text = "User activated"
                activeLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                activateButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                activateButton.setTitle("Deactivate", for: .normal)
            }else {
                activeLabel.text = "Waiting for activation"
                activeLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                activateButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                activateButton.setTitle("Activate", for: .normal)
            }
        }
    }

    @IBAction func activate(_ sender: UIButton) {
        let alert = UIAlertController(title: "Send notification", message: "Do you want to notify user?", preferredStyle: .actionSheet)
        let activate: (Bool) -> Void = {
            isNotify in
            self.api.activateUser(id: self.user!.id, isActive: !self.user!.active, notify: isNotify) {
                response -> Void in
                self.reloadUser()
            }
        }
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            activate(true)
        }))
        
        alert.addAction(UIAlertAction(title: "Without notification", style: .default, handler: {
            action in
            activate(false)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    private func reloadUser() {
        api.getUser(id: user!.id) {
            user -> Void in
            self.user!.replace(user: user)
            self.setupUI()
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
