//
//  SecondViewController.swift
//  ParseInstaClone
//
//  Created by Sefa Çelik on 30.05.2020.
//  Copyright © 2020 Sefa Celik. All rights reserved.
//

import UIKit
import Parse

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // UI
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        uploadButton.isEnabled = false
        
        imageView.isUserInteractionEnabled = true
        let rec = UITapGestureRecognizer(target: self, action: #selector(selectPic))
        imageView.addGestureRecognizer(rec)
        
        let rec2 = UITapGestureRecognizer(target: self, action: #selector(UploadVC.hideKeyboard))
        self.view.addGestureRecognizer(rec2)
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func selectPic(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.uploadButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        uploadButton.isEnabled = false
        
        let object = PFObject(className: "Posts")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        let pfImage = PFFileObject(name: "image", data: data!)
        
        let uuid = UUID().uuidString
        let uuidPost = "\(uuid) \(PFUser.current()!.username!)"
        object["postimage"] = pfImage
        object["postcomment"] = commentText.text
        object["postowner"] = PFUser.current()!.username
        object["postuuid"] = uuidPost
        
        object.saveInBackground { (success, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Bilinmeyen Hata", preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(ok)
                self.present(alert,animated: true,completion: nil)
            } else {
                self.commentText.text = ""
                self.imageView.image = UIImage(named: "selectimage")
                self.tabBarController?.selectedIndex = 0
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPost"), object: nil)
            }
        }
    }
    

}























