//
//  FirstViewController.swift
//  ParseInstaClone
//
//  Created by Sefa Çelik on 30.05.2020.
//  Copyright © 2020 Sefa Celik. All rights reserved.
//

import UIKit
import Parse

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // UI
    @IBOutlet weak var tableView: UITableView!
    
    // Vars
    var postOwnerArray = [String]()
    var postCommentArray = [String]()
    var postUUIDArray = [String]()
    var postImageArray = [PFFileObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newPost"), object: nil)
    }
    
    @objc func getData(){
        
        let query = PFQuery(className: "Posts")
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground { (objects, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Bilinmeyen Hata", preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(ok)
                self.present(alert,animated: true,completion: nil)
            } else {
                
                self.postOwnerArray.removeAll(keepingCapacity: false)
                self.postCommentArray.removeAll(keepingCapacity: false)
                self.postUUIDArray.removeAll(keepingCapacity: false)
                self.postImageArray.removeAll(keepingCapacity: false)
                
                if objects!.count > 0 {
                    
                    for object in objects!{
                        self.postOwnerArray.append(object.object(forKey: "postowner") as! String)
                        self.postCommentArray.append(object.object(forKey: "postcomment") as! String)
                        self.postUUIDArray.append(object.object(forKey: "postuuid") as! String)
                        self.postImageArray.append(object.object(forKey: "postimage") as! PFFileObject)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        PFUser.logOutInBackground { (error) in
            if error != nil{
                self.makeAlert(msg: error?.localizedDescription ?? "Bilinmeyen Hata")
            } else {
                self.performSegue(withIdentifier: "toSignInVC", sender: nil)
            }
        }
    }
    
    func makeAlert(msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postOwnerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as! FeedCell
        cell.userNameLabel.text = postOwnerArray[indexPath.row]
        cell.postCommentLabel.text = postCommentArray[indexPath.row]
        cell.postUuidLabel.text = postUUIDArray[indexPath.row]
        postImageArray[indexPath.row].getDataInBackground { (data, error) in
            if error != nil {
                self.makeAlert(msg: error?.localizedDescription ?? "Bilinmeyen Hata")
            } else {
                cell.imageView?.image = UIImage(data: data!)
            }
        }
        return cell
    }
}

































