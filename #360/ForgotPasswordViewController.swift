//
//  ForgotPasswordViewController.swift
//  #360
//
//  Created by Chan Sin Tik on 3/1/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var emailText: UITextField!

    @IBAction func submit(_ sender: Any) {
        
        if self.emailText.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email address.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            var message = ""
            var title = ""
            FIRAuth.auth()?.sendPasswordReset(withEmail: self.emailText.text!, completion: { (error) in
                if error != nil {
                    title = "Error"
                    message = (error?.localizedDescription)!
                } else {
                    title = "Success"
                    message = "Email password has been sent."
                    self.emailText.text = ""
                }
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }
}
