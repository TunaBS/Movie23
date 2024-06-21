//
//  RegistrationViewController.swift
//  Movie23
//
//  Created by BS00880 on 21/6/24.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextFied: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func registeredButtonPressed(_ sender: UIButton) {
        
        if let emailId = emailTextField.text, let passwords = passwordTextField.text {
            Auth.auth().createUser(withEmail: emailId, password: passwords) { authResult, error in
                // ...
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "RegisterToHomePage", sender: self)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
