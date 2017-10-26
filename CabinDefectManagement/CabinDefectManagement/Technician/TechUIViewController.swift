//
//  TechUIViewController.swift
//  CabinDefectManagement
//
//  Created by qwerty on 25/10/17.
//  Copyright © 2017 Sim Kim Wee. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class TechUIViewController: UIViewController {

    
    @IBOutlet weak var defectNo: UILabel!
    @IBOutlet weak var actionField: UITextView!
    @IBOutlet weak var locationField: UILabel!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var aircraftField:UILabel!
    @IBOutlet weak var depTimeField: UILabel!
    @IBOutlet weak var arrTimeField: UILabel!
    @IBOutlet weak var historyField: UILabel!
    @IBOutlet weak var spareField: UILabel!
    var ref : DatabaseReference?
    var storageref : StorageReference?
    var complete : String?
    var defectid = "CD123456"
    var groundTid : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // retrieve data from first table
        self.defectNo.text = defectid
        ref = Database.database().reference()
        ref?.child("Defects").child(defectid).observe(.value, with: {
            (snapshot) in
            print(snapshot)
            let values = snapshot.value as? NSDictionary
            self.groundTid = values?["GroundTimeID"] as? String
            self.actionField.text = values?["Action"] as? String
            self.historyField.text = values?["Ageing"] as? String
            self.dateField.text = values?["Date Raised"] as? String
            self.spareField.text = values?["Spare Require"] as? String
            self.aircraftField.text = values?["Aircraft"] as? String
            self.ref?.child("GroundTime").child(self.groundTid!).observe(.value, with: {(snapshot) in
                let lvalue = snapshot.value as? NSDictionary
                self.arrTimeField.text = lvalue?["Arr Time"] as? String
                self.depTimeField.text = lvalue?["Dep Time"] as? String
                self.locationField.text = lvalue?["Location"] as? String
            })
        })
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Submit(_ sender: Any) {
        let imageName = NSUUID().uuidString
        storageref = Storage.storage().reference().child("\(imageName).png")
        if let upload = UIImagePNGRepresentation(self.image.image!)
        {
            storageref?.putData(upload,metadata: nil, completion : {(metadata,error) in
                if error != nil
                {
                    print(error?.localizedDescription)
                }
        //Update database
                let action = self.actionField.text
                let POST : [String : AnyObject] =
                    [
                        "Action" : action as AnyObject,
                        "Photo" : metadata?.downloadURL()?.absoluteString as AnyObject
                    ]
                self.ref = Database.database().reference().child("Defect").child(self.defectid)
                self.ref?.updateChildValues(POST)
                return
            })
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
