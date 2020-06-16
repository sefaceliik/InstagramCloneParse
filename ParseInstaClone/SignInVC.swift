//
//  SignInVC.swift
//  ParseInstaClone
//
//  Created by Sefa Çelik on 30.05.2020.
//  Copyright © 2020 Sefa Celik. All rights reserved.
//

import UIKit
import Parse

class SignInVC: UIViewController {
    
    //UI
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != ""{

            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(msg: error?.localizedDescription ?? "Bilinmeyen Hata")
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
            
            
        } else {
            makeAlert(msg: "Username/Password ?")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != ""{

            let user = PFUser()
            user.username = usernameText.text
            user.password = passwordText.text
            
            user.signUpInBackground { (success, error) in
                if error != nil{
                    self.makeAlert(msg: error?.localizedDescription ?? "Bilinmeyen Hata")
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
            
        } else {
            makeAlert(msg: "Username/Password ?")
        }
    }
    
    func makeAlert(msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
    
    
}


































