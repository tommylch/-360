//
//  LoginViewController.swift
//  #360
//
//  Created by Chan Sin Tik on 3/1/2017.
//  Copyright © 2017 tik. All rights reserved.
//

import UIKit
import Firebase

import Fabric

protocol LoadDetailViewDelegate {
    func buildTable()
}

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    // 2. declare delegate property
    var delegate: LoadDetailViewDelegate?
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        passwordText.resignFirstResponder()
        return true;
    }
    @IBAction func login(_ sender: Any) {
        self.dismissKeyboard()

        if let email = emailText.text, let password = passwordText.text {
            
            if email.isEmpty || password.isEmpty {
                // send alert that one of the fields is empty (email address and password fields cannot be empty)
                displayAlert(messageToDisplay: "Please fill in all information.")
            } else {
                let isEmailAddressValid = verifyEmailAddressValid(emailAddressString: email)
                // verify email address is valid
                if isEmailAddressValid {
                    // verify password is valid
                    if password.characters.count >= 6 {
                        firebaseEmailAuth(email: email, password: password)
             
                    } else {
                        // fire alert controller indicating that password is too short in length
                        displayAlert(messageToDisplay: "The password you provided is too short. You need at least 6 characters.")
                    }
                } else {
                    // fire alert controller stating that email address is invalid and must be enter a valid email address
                    displayAlert(messageToDisplay: "The email address you provided is invalid. Please make sure the email address is correct.")
                }
            }
        }
    }
    
    func firebaseEmailAuth(email: String, password: String) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                // firebase authentication successful
                let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDel.logUser()
            } else {
                self.displayAlert(messageToDisplay: (error?.localizedDescription)!)
            }
        })
            }


    
    // verify email address
    func verifyEmailAddressValid(emailAddressString: String) -> Bool{
        var returnValue = true
        
        /* regex options
         "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
         "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
         "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
         */
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,6}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegex, options: NSRegularExpression.Options.caseInsensitive)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, options: [], range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return returnValue
    }
    
    
    // alert controller to display message to user
    func displayAlert(messageToDisplay: String) {
        
        let alertController = UIAlertController(title: "Problem With Login", message: messageToDisplay, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Please Try Again.", style: .default) { (action: UIAlertAction!) in
            self.emailText.text = ""
            self.passwordText.text = ""
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // function to complete the signin process :: post new user in firebase database and segue to DetailView
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        // 3. implement delegate method
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDel.logUser()
    }

    
    

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


