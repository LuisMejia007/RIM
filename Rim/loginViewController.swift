//
//  ViewController.swift
//  Rim
//
//  Created by Chatan Konda on 9/10/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func loginButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var registerButton: UIButton!
    @IBAction func registerButton(_ sender: Any) {
        
       // dismiss(animated: true, completion: nil)
    }
    
    
}

