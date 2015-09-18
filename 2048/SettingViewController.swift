//
//  SettingViewController.swift
//  2048
//
//  Created by e on 15/9/13.
//  Copyright (c) 2015年 e. All rights reserved.
//

import UIKit
import AVFoundation

class SettingViewController: UIViewController {
    /*

    var mainView:MainViewController
    var textNum:UITextField!
    var segDimension:UISegmentedControl!
    
//    init(mainview:MainViewController)
//    {
//        self.mainView = mainview
//        super.init(nibName:nil, bundle:nil)
//    }

    required init(coder aDecoder: NSCoder, mainview:MainViewController) {
        self.mainView = mainview
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupController()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func setupController()
    {
        var cv = ControlView()
        var val:Int
        
//        textNum = cv.createTextField(String(self.mainView.maxnumber), action: Selector("numChanged"), sender: self)
        textNum = cv.createTextField(String(val), action: Selector("textFieldShouldReturn"), sender:self)
        textNum.frame.origin.x = 50
        textNum.frame.origin.y = 100
        textNum.frame.size.width = 200
        textNum.returnKeyType = UIReturnKeyType.Done
        
        self.view.addSubview(textNum)
        
        segDimension = cv.createSegment(["3x3", "4x4", "5x5"], action: <#Selector#>("dimensionChanged"), sender: self)
        
        segDimension.frame.origin.x = 50
        segDimension.frame.origin.y = 200
        segDimension.frame.size.width = 200
        
        self.view.addSubview(segDimension)
        
    }*/
    
    func textFieldShouldReturn(textField:UITextField)->Bool
    {
        textField.resignFirstResponder()
        println("num Changed!")
        
        if(textField.text != "\(mainView.maxnumber)")
        {
            var num = textField.text.toInt()
            mainView.maxnumber = num!
        }
        return true
    }
    
    func dimensionChanged(sender:SettingViewController)
    {
        var segVals = [3,4,5]
        mainView.dimension = segVals[segDimension.selectedSegmentIndex]
        //mainView.resetUI()
        
    }
*/
    
}

