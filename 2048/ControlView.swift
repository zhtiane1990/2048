//
//  ControlView.swift
//  2048
//
//  Created by e on 15/9/14.
//  Copyright (c) 2015年 e. All rights reserved.
//

import UIKit

class ControlView
{
    let defaultFrame = CGRectMake(0, 0, 100, 30)
    
    func createButton(title:String, action:Selector, sender:UIViewController) -> UIButton
    {
        var button = UIButton(frame: defaultFrame)
        
        button.backgroundColor = UIColor.orangeColor()
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.textColor = UIColor.whiteColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        
        button.addTarget(sender, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }
    
    func createTextField()
    {
        
    }
    
    func createLabel()
    {
        
    }
}
