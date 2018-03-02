//
//  ViewController.swift
//  PSE ATG Admin
//
//  Created by TAWEERAT CHAIMAN on 1/3/2561 BE.
//  Copyright © 2561 TAWEERAT CHAIMAN. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController, UITextFieldDelegate {
    
    let apiManager = ApiManager()
    let SIGNIN_URL = "https://atg.padungsilpa.group/_api/auth/signin"
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        hideNavigationBar()
        if UserController.getCurrentUser() != nil {
            goToDashboard()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: Nagivations
    func goToDashboard() {
        let dashboardViewController = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")
        self.navigationController?.pushViewController(dashboardViewController!, animated: true)
        dismiss(animated: false, completion: nil)
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // Mark: Actions
    @IBAction func signin(_ sender: UIButton) {
        let body = [
            "email": emailTextField.text!,
            "password": passwordTextField.text!
        ]
        
        apiManager.fetch(url: SIGNIN_URL, header: nil, body: body, method: "POST") {
            response -> Void in
            if response != nil {
                if response!["success"] as! Bool {
                    let user = response!["data"] as! [String: Any]
                    if(UserController.saveUser(user: user)) {
                        self.goToDashboard()
                    }
                }else {
                   self.messageLabel.text = (response!["error"] as! String)
                }
            }
        }
    }
    
    //Mark: TextField Deletation methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

