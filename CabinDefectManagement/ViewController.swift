//
//  ViewController.swift
//  CabinDefectManagement
//
//  Created by Sim Kim Wee on 24/10/17.
//  Copyright © 2017 Sim Kim Wee. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    var ref : DatabaseReference?
    var etype : String?
    
    override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
    }
    @IBAction func Login(_ sender: Any) {
        //check whether both fields are filled
        guard let email = emailTextField.text,
        email != "",
        let pass = PasswordTextField.text,
        pass != ""
        else
        {
            // prompt error
            let alertController = UIAlertController(title : "Missing Info", message: "Please fill in all the missing fields.", preferredStyle: .alert)
            let action = UIAlertAction(title: "cancel",style: .cancel, handler : nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        // authenticate user
        Auth.auth().signIn(withEmail: email, password: pass, completion : {(user,error) in
            guard error == nil
            else
            {
                let alertController = UIAlertController(title: "Error", message : error!.localizedDescription, preferredStyle : .alert)
                let action = UIAlertAction(title:"Ok",style: .cancel,handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            guard let user = user else { return }
            //load database
            self.ref = Database.database().reference().child("Employee")
            self.ref?.queryOrderedByKey().observe(.childAdded, with: {
                (snapshot) in
                let value = snapshot.value as? NSDictionary
                let emailvalue = value?["Email"] as? String ?? ""
                if(emailvalue == email)
                {
                    print(emailvalue)
                    let type = value?["Type"] as? String ?? ""
                    self.etype = type.lowercased()
                    print(type)
                    switch (self.etype)
                    {
                    case Type.technician.rawValue?:
                        print("a")
                    case Type.supervisor.rawValue?:
                        print("b")
                    case Type.planner.rawValue?:
                        print("c")
                    default:
                        print("d")
                    }
                }
            }) {(error) in
                print(error.localizedDescription)
            }
        })
        
    }
    
}
