//
//  LoginViewController.swift
//  Ride Key
//
//  Created by VASP on 30/01/15.
//  Copyright (c) 2015 VASP. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var Image: UIImageView!
    @IBOutlet var usernametext: UITextField!
    @IBOutlet var passwordtext: UITextField!
    @IBOutlet var remembermeswitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func LoginButtontapped(sender: AnyObject) {
        self.performSegueWithIdentifier("Login", sender: self)
    }
    
    @IBAction func canceltapped(sender: AnyObject) {
        exit(0)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
