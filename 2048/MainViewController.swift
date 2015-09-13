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
        
        getNumber()
        
        for i in 0..<10
        {
            getNumber()
        }
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
    
    func getNumber()
    {
        let randv = Int(arc4random_uniform(10))
        println(randv)
        var seed: Int = 2
        if (randv == 1)
        {
            seed = 4
        }
        let col = Int(arc4random_uniform(UInt32(dimension)))
        let row = Int(arc4random_uniform(UInt32(dimension)))
        
        insertTile((row, col), value: seed)
    }
    
    func insertTile(pos: (Int, Int), value: Int)
    {
        let (row, col) = pos;
        
        let x = 30 + CGFloat(col) * (width + padding)
        let y = 150 + CGFloat(row) * (width + padding)
        
        let tile = TileView(pos: CGPointMake(x,y), width: width, value: value)
        self.view.addSubview(tile)
        self.view.bringSubviewToFront(tile)
        
        tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        
        UIView.animateWithDuration(0.3, delay: 0.1, options: UIViewAnimationOptions.TransitionNone, animations: {
            () -> Void in
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(1, 1))
            })
            {
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.08, animations: { () -> Void in
                    
                    tile.layer.setAffineTransform(CGAffineTransformIdentity)
                })
        }
    }
}

