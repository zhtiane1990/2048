//
//  MainViewController.swift
//  2048
//
//  Created by e on 15/9/13.
//  Copyright (c) 2015年 e. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //
    var dimension: Int = 4
    
    //
    var maxnumber: Int = 2048
    
    var width: CGFloat = 50
    
    //
    var padding: CGFloat = 6
    
    var backgrounds:Array<UIView> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
    }

    func setupBackground() {
        var x: CGFloat = 30
        var y: CGFloat = 150
        
        for i in 0..<dimension
        {
            y = 150
            for j in 0..<dimension
            {
                var background = UIView(frame: CGRectMake(x, y, width, width))
                
                background.backgroundColor = UIColor.darkGrayColor()
                
                self.view.addSubview(background)
                
                backgrounds.append(background)
                
                y += padding + width
                
            }
            x += padding + width
            
        }
    }
}
