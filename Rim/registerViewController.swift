//
//  registerViewController.swift
//  Rim
//
//  Created by Chatan Konda on 9/18/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class registerViewController: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    
        profilePicture.isUserInteractionEnabled = true
        profilePicture.addGestureRecognizer(tapGestureRecognizer)
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        jobTextField.delegate = self
        companyTextField.delegate = self

        
    }
    
    
    @IBOutlet weak var jobTextField: UITextField!//position
    @IBOutlet weak var companyTextField: UITextField!

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        jobTextField.resignFirstResponder()
        companyTextField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        jobTextField.resignFirstResponder()
        companyTextField.resignFirstResponder()
        
        return true
    }
    
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
            
            selectedImageFromPicker = editedImage
        } else if let originalImage =
            info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker
        {
            profilePicture.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    

  
    @IBAction func loginButton(_ sender: Any) {
        
        print("reach")
        handleRegister()//register and authenticate
        print("reached here 2")
    }
    
    
    func registerUserintoDatabaseWithUID(uid: String, values: [String: AnyObject]){
        
        let ref = FIRDatabase.database().reference()
        let usersReference  = ref.child("Users").child(uid)//create auto ID for child
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err!)
                return
            }
            let user = User()
            
            //this setter crashes if keys dont match
            
            
            //  AppDelegate.user.initialize(username: nil, email: self.emailtextField.text, password: self.passwordtextField.text, userID: uid)
            
                print("reach 4233")
            AppDelegate.user.setValuesForKeys(values)
                print("reach 4332111")
            user.setValuesForKeys(values)
            print("reach 4")
            self.performSegue(withIdentifier: "gotoHome", sender: self)
        })
    }
    
    
    
    func handleRegister(){
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else{
            
            print("Service Unavailable, Please try again")
            return//if all fields not filled out completely, logout
        }
        //firebase authtification access( if not authenticated then throw error)
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            guard let uid = user?.uid else {
                return
            }
            // if user != nil {
                print("reach 11")
            
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("\(imageName).png")
            
            let profileImage = self.profilePicture.image!
            
            if let uploadData = UIImagePNGRepresentation(profileImage){
                
                storageRef.put(uploadData, metadata: nil, completion: {(metadata, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                        
                            print("reach 41")
                        let values = ["username": name, "email": email, "password": password, "userID": uid, "profileImageUrl": profileImageUrl]
                        
                        AppDelegate.user.initialize(username: name, email: self.emailTextField.text, password: self.passwordTextField.text, userID: uid, profileImageUrl: profileImageUrl)
                        
                            print("reach 5")
                        self.registerUserintoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                        
                            print("reach 432")
                    }
                    
                })
                //  AppDelegate.user.initialize(username: nil, email: self.emailtextField.text, password: self.passwordtextField.text, userID: uid, profileImageURL: profileImageUrl )
            }
            else {
                print("register error")
                //Error: check error
            }
            //user has been authenticated
        })
    }

    
    
    

}
