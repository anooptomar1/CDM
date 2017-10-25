//
//  TechUITableViewController.swift
//  CabinDefectManagement
//
//  Created by qwerty on 25/10/17.
//  Copyright © 2017 Sim Kim Wee. All rights reserved.
//

import UIKit
import Firebase

class TechUITableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    var ref : DatabaseReference?
    var defects = [String]()
    func numberofSections(in tableView : UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TechnicianID",for : indexPath ) as!
        TechUITableViewCell
        return cell
    }
    

    
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("a")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchDefects()
    {
        var nam : String?
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value!["name"] as? String
            nam = name
        })
        ref = Database.database().reference().child("Defects")
        ref?.queryOrdered(byChild: "Complete").queryEqual(toValue: false).observe(.childAdded, with: {(snapshot) in
            let values = snapshot.value as? NSDictionary
            let assign = values?["AssignedTo"] as? String
            if (assign == nam)
            {
                let dno = values?["Defect No"] as? String
                self.defects.insert(dno!,at:0)
                DispatchQueue.main.async (
                    execute: {
                        self.TableView.reloadData()
                    })
            }
        })
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
