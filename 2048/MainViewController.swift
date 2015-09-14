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
    
    var gmodel: GameModel
    
    var tiles:Dictionary<NSIndexPath, TileView>
    
    var tileVals: Dictionary<NSIndexPath, Int>
    
    
    required init(coder aDecoder: NSCoder) {
        self.gmodel = GameModel(dimension: self.dimension)
        self.tiles = Dictionary()
        self.tileVals = Dictionary()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setButton()
        setupSwipeGuestures()
        getNumber()
        
        for i in 0..<10
        {
            getNumber()
        }
    }

    func setButton()
    {
        var cv = ControlView()
        var btnreset = cv.createButton("reset", action: Selector("resetTapped"), sender: self)
        btnreset.frame.origin.x = 50
        btnreset.frame.origin.y = 450
        self.view.addSubview(btnreset)
        
        var btngen = cv.createButton("new number", action:Selector("genTapped"), sender: self)
        
        btngen.frame.origin.x = 170
        btngen.frame.origin.y = 450
        self.view.addSubview(btngen)
        
        
    }
    
    func setupSwipeGuestures()
    {
        //up
        let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeUp"))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(upSwipe)
        
        //down
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeDown"))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(downSwipe)
        
        //left
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeLeft"))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(leftSwipe)
        
        //right
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeRight"))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightSwipe)
        
    }
    
    func swipeUp()
    {
        println("swipeUp")
        for i in 0..<dimension
        {
            for j in 0..<dimension
            {
                var row: Int = i
                var col: Int = j
                var key = NSIndexPath(forRow: row, inSection: col)
                
                if(tileVals.indexForKey(key) != nil)
                {
                    if(row > 3)
                    {
                        removeKeyTile(key)
                        
                        var index = row * dimension + col - dimension
                        row = Int(index/dimension)
                        col = index - row * dimension
                        
                        //insertTile(pos:(row, col), value: tileVals.indexForKey(key))
                        
                        insertTile((row, col), value: tileVals[key]!)
                    
                    }
                }
                
            }
            

        }
        
    }
    
    func swipeDown()
    {
        println("swipeDown")
    }
    
    func swipeLeft()
    {
        println("swipeLeft")
    }
    
    func swipeRight()
    {
        println("swipeRight")
    }
    
    func removeKeyTile(key: NSIndexPath)
    {
        var tile = tiles[key]
        var tileval = tileVals[key]
        
        tile?.removeFromSuperview()
        tiles.removeValueForKey(key)
        tileVals.removeValueForKey(key)
    }
    
    func resetTapped()
    {
        println("reset")
        for(key, tile) in tiles
        {
            tile.removeFromSuperview()
        }
        tiles.removeAll(keepCapacity: true)
        tileVals.removeAll(keepCapacity: true)
        gmodel.initTiles()
    }
    
    func genTapped()
    {
        println("genTapped")
        getNumber()
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
        
        if(gmodel.isFull())
        {
            println("postion full")
            return
        }
        if(gmodel.setPosition(row, col: col, value: seed) == false)
        {
            getNumber()
            return
        }
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
        
        var index = NSIndexPath(forRow: row, inSection: col)
        tiles[index] = tile
        tileVals[index] = value
        
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

