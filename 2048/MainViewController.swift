
//
//  MainViewController.swift
//  2048
//
//  Created by e on 15/9/13.
//  Copyright (c) 2015年 e. All rights reserved.
//

import UIKit

enum Animation2048Type
{
    case None   //无动画
    case New    //新出现动画
    case Merge  //合并动画
}

class MainViewController: UIViewController {

    //
    var dimension: Int = 4
    
    //
    var maxnumber: Int = 16
    
    var width: CGFloat = 50
    
    //
    var padding: CGFloat = 6
    
    var backgrounds:Array<UIView> = []
    
    var gmodel: GameModel!
    
    var tiles:Dictionary<NSIndexPath, TileView>
    
    var tileVals: Dictionary<NSIndexPath, Int>
    
    var score:ScoreView! //加一个！号和不加有很大区别，区别在要不要初始化
    
    var bestscore:BestScoreView!//加一个！号和不加有很大区别，区别在要不要初始化
    
    required init(coder aDecoder: NSCoder) {

        self.tiles = Dictionary()
        self.tileVals = Dictionary()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setButton()
        setupSwipeGuestures()
        setupScoreLabels()
        
        self.gmodel = GameModel(dimension: self.dimension, maxnumber:self.maxnumber,score:score, bestscore:bestscore)
        
        getNumber()
        
//        for i in 0..<10
//        {
//            getNumber()
//        }
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
    
    func setupScoreLabels()
    {
        score = ScoreView()
        score.frame.origin.x = 50
        score.frame.origin.y = 80
        score.changeScore(value: 0)
        self.view.addSubview(score)
        
        bestscore = BestScoreView()
        bestscore.frame.origin.x = 170
        bestscore.frame.origin.y = 80
        bestscore.changeScore(value: 0)
        self.view.addSubview(bestscore)
        
        
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
    
    func printTiles(tiles: Array<Int>)
    {
        for var i = 0; i < tiles.count; i++
        {
            if (i+1) % Int(dimension) == 0
            {
                println(tiles[i])
            }
            else
            {
                print("\(tiles[i])\t")
            }
        }
        
        println("")
    }
    
    func swipeUp()
    {
        println("swipeUp")
        
        gmodel.reflowUp()
        gmodel.mergeUP()
        gmodel.reflowUp()
//        resetUI()
        
        initUI()
        if(!gmodel.isSuccess())
        {
            getNumber()
        }
    }
    
    func swipeDown()
    {
        println("swipeDown")
        gmodel.reflowDown()
        gmodel.mergeDown()
        gmodel.reflowDown()
//        resetUI()
        
        initUI()
        
        if(!gmodel.isSuccess())
        {
            getNumber()
        }
    }
    
    func swipeLeft()
    {
        println("swipeLeft")
        gmodel.reflowLeft()
        gmodel.mergeLeft()
        gmodel.reflowLeft()
//        resetUI()
        
        initUI()
        
        if(!gmodel.isSuccess())
        {
            getNumber()
        }
    }
    
    func swipeRight()
    {
        println("swipeRight")
        gmodel.reflowRight()
        gmodel.mergeRight()
        gmodel.reflowRight()
        
//        resetUI()
        
        initUI()
        
        if(!gmodel.isSuccess())
        {
            getNumber()
        }
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
        resetUI()
        gmodel.initTiles()
    }
    
    func initUI()
    {
        var index:Int
        var key:NSIndexPath
        var tile:TileView
        var tileval:Int
        var success = false
        
        if(gmodel.isSuccess())
        {
            var alerView = UIAlertView()
            alerView.title = "恭喜你通关"
            alerView.message = "你真棒，通关了"
            alerView.addButtonWithTitle("OK")
            alerView.show()
        }
        for i in 0..<dimension
        {
            for j in 0..<dimension
            {
                index = i * self.dimension + j
                key = NSIndexPath(forRow: i, inSection: j)
                

                
                //原来界面没有值，模型数据中有值
                if((gmodel.tiles[index]>0)&&(tileVals.indexForKey(key) == nil))
                {
                    insertTile((i,j), value: gmodel.mtiles[index], aType: Animation2048Type.Merge)
                }
                
                //原来界面中有值，现在模型中没有值了
                if((gmodel.tiles[index]==0)&&(tileVals.indexForKey(key) != nil))
                {
                    tile = tiles[key]!
                    tile.removeFromSuperview()
                    
                    tiles.removeValueForKey(key)
                    tileVals.removeValueForKey(key)
                    
                }
                
                //原来有值，但现在还有值
                if((gmodel.tiles[index] > 0) && (tileVals.indexForKey(key) != nil))
                {
                    tileval = tileVals[key]!
                    if(tileval != gmodel.tiles[index])
                    {
                        tile = tiles[key]!
                        tile.removeFromSuperview()
                        
                        tiles.removeValueForKey(key)
                        tileVals.removeValueForKey(key)
                        
                        insertTile((i,j), value: gmodel.mtiles[index], aType: Animation2048Type.Merge)
                    }
                    
                    
                }
                
//                var index = i * self.dimension + j
//                if gmodel.mtiles[index] != 0
//                {
//                    insertTile((i,j), value: gmodel.mtiles[index])
//                }
                
                //游戏通关
//                if(gmodel.tiles[index] >= maxnumber)
//                {
//                    success = true
//                    break
//                }
            }
        }
        
//        if(success == true)
//        {
//            var alerView = UIAlertView()
//            alerView.title = "恭喜你通关"
//            alerView.message = "你真棒，通关了"
//            alerView.addButtonWithTitle("OK")
//            alerView.show()
//        }
    }
    
    func resetUI()
    {
        for(key, tile) in tiles
        {
            tile.removeFromSuperview()
        }
        tiles.removeAll(keepCapacity: true)
        tileVals.removeAll(keepCapacity: true)
        score.changeScore(value: 0)
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
            var alerView = UIAlertView()
            alerView.title = "game over"
            alerView.message = "game over"
            alerView.addButtonWithTitle("OK")
            alerView.show()
            return
        }
        if(gmodel.setPosition(row, col: col, value: seed) == false)
        {
            getNumber()
            return
        }
        insertTile((row, col), value: seed, aType: Animation2048Type.New)
    }
    
    func insertTile(pos: (Int, Int), value: Int, aType: Animation2048Type)
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
        
        if(aType == Animation2048Type.None)
        {
            return
        }
        else if(aType == Animation2048Type.New)
        {
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        }
        else if(aType == Animation2048Type.Merge)
        {
        
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.8, 0.8))
        }
        
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

