//
//  LoginController.swift
//  Shopping
//
//  Created by Kewal Kanojia on 12/03/17.
//  Copyright © 2017 Kewal Kanojia. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
    
    private let ContactSegue = "showHome"
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailError: UIImageView!
    @IBOutlet weak var passwordError: UIImageView!
    @IBOutlet weak var errorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let _ = self.checkLogin(contactSegue: self.ContactSegue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Code
        let _ = self.checkLogin(contactSegue: self.ContactSegue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //For alert Box 
    //self.createAlert(title: "Could not post image", message: "Please try again later")
    
    
    @IBAction func doLogin(_ sender: Any) {
        if(emailTxt.text == "") {
            errorMsg.isHidden = false
            errorMsg.text = "Please enter email id."
            emailError.isHidden = false
            emailTxt.becomeFirstResponder()
        } else if(passwordTxt.text == "") {
            emailError.isHidden = true
            errorMsg.isHidden = false
            errorMsg.text = "Please enter password."
            passwordError.isHidden = false;
            passwordTxt.becomeFirstResponder()
        } else {
            errorMsg.isHidden = true
            emailError.isHidden = true
            passwordError.isHidden = true
            
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            activityIndicator.color = UIColor.darkGray
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            //Login Request
            let postString = "email=\(emailTxt.text!)&password=\(passwordTxt.text!)"
            let a = doHttpRequest(url: "login.php", method: "POST", params: postString);
            let status = a?["status"] as! String
            if(status == "false") {
                errorMsg.isHidden = false
                errorMsg.text = a?["error"] as? String
            } else {
                let sessionToken = a?["sessionToken"] as! String
                UserDefaults.standard.set(sessionToken, forKey: "sessionToken")
                self.performSegue(withIdentifier: "showHome", sender: self)
            }
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
