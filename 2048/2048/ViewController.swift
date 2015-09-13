//
//  ViewController.swift
//  2048
//
//  Created by e on 15/9/13.
//  Copyright (c) 2015年 e. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGame(sender: UIButton) {
        let alertView = UIAlertView()
        alertView.title = "start"
        alertView.message = "are you ready?"
        alertView.addButtonWithTitle("go!")
        alertView.show()
        alertView.delegate = self
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.performSegueWithIdentifier("startGame", sender:nil)
    }
}

