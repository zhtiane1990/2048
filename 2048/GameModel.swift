//
//  GameModel.swift
//  2048
//
//  Created by e on 15/9/14.
//  Copyright (c) 2015年 e. All rights reserved.
//

import Foundation

class GameModel
{
    var dimension: Int = 0
    
    //4*4 = 16
    var tiles: Array<Int>! //???? ! way
    var mtiles: Array<Int>!
    
    var scoreDelegate:ScoreViewProtocol!
    var bestscoreDelegate:ScoreViewProtocol!
    
    var score:Int! = 0
    var bestscore:Int! = 0
    
    init(dimension: Int, score:ScoreViewProtocol, bestscore:ScoreViewProtocol){
        self.dimension = dimension
        self.scoreDelegate = score
        self.bestscoreDelegate = bestscore
        initTiles()
        
    }
    
    func initTiles()
    {
        self.tiles = Array<Int>(count: self.dimension*self.dimension, repeatedValue: 0)
        
        self.mtiles = Array<Int>(count: self.dimension*self.dimension, repeatedValue: 0)
    }
    
    func setPosition(row: Int, col:Int, value:Int)->Bool
    {
        assert((row >= 0 && row < dimension), "OK")
        assert((col >= 0 && col < dimension), "OK")
        
        //4row4col, 3*4+3 = 15
        var index = self.dimension*row + col
        var val = tiles[index]
        if(val > 0)
        {
            println("had value")
            return false
        }
        else
        {
            tiles[index]=value
            return true
        }
        
    }
    
    func emptyPosition()-> [Int]
    {
        var emptyTiles = Array<Int>()
        
        for i in 0..<(dimension * dimension)
        {
            if(tiles[i] == 0)
            {
                emptyTiles.append(i)
            }
        }
        
        return emptyTiles
    }
    
    func isFull()-> Bool
    {
        if(emptyPosition().count == 0)
        {
            return true
        }
        return false
    }
    
    func copyToMtiles()
    {
        for i in 0..<self.dimension * self.dimension
        {
            mtiles[i] = tiles[i]
        }
    }
    
    func copyFromMtiles()
    {
        for i in 0..<self.dimension * self.dimension
        {
            tiles[i] = mtiles[i]
        }
    }
    
    func reflowUp()
    {
        copyToMtiles()
        
        var index:Int
        for var i=dimension-1; i>0; i--
        {
            for j in 0..<dimension
            {
                index = self.dimension * i + j
                if((mtiles[index - self.dimension] == 0)
                   && (mtiles[index] > 0))
                {
                    mtiles[index - self.dimension] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex: Int = index
                    while(subindex+self.dimension < mtiles.count)
                    {
                        if(mtiles[subindex + self.dimension] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex + self.dimension]
                            mtiles[subindex + self.dimension] = 0
                        }
                        subindex += self.dimension
                    }
                }
            }
        }
        
        copyFromMtiles()

    }
    
    func reflowDown()
    {
        copyToMtiles()
        
        var index:Int
        for i in 0..<dimension-1
        {
            for j in 0..<dimension
            {
                index = self.dimension * i + j

                if((mtiles[index + self.dimension] == 0)
                    && (mtiles[index] > 0))
                {
                    mtiles[index + self.dimension] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex: Int = index
                    while(subindex - self.dimension >= 0)
                    {
                        if(mtiles[subindex - self.dimension] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex - self.dimension]
                            mtiles[subindex - self.dimension] = 0
                        }
                        subindex -= self.dimension
                    }
                }
            }
        }
        
        copyFromMtiles()
        
    }
    
    func reflowLeft()
    {
        copyToMtiles()
        
        var index:Int
        for i in 0..<dimension
        {
            for var j = dimension-1; j>0; j--
            {
                index = self.dimension * i + j
                if((mtiles[index - 1] == 0)
                    && (mtiles[index] > 0))
                {
                    mtiles[index - 1] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex: Int = index
                    while((subindex+1) < (i*self.dimension + self.dimension))
                    {
                        if(mtiles[subindex + 1] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex + 1]
                            mtiles[subindex + 1] = 0
                        }
                        subindex += 1
                    }
                }
            }
        }
        
        copyFromMtiles()
        
    }

    func reflowRight()
    {
        copyToMtiles()
        
        var index:Int
        for i in 0..<dimension
        {
            for j in 0..<dimension-1
            {
                index = self.dimension * i + j
                if((mtiles[index + 1] == 0)
                    && (mtiles[index] > 0))
                {
                    mtiles[index + 1] = mtiles[index]
                    mtiles[index] = 0
                    
                    var subindex: Int = index
                    while((subindex-1) >  (i*self.dimension - 1))
                    {
                        if(mtiles[subindex - 1] > 0)
                        {
                            mtiles[subindex] = mtiles[subindex - 1]
                            mtiles[subindex - 1] = 0
                        }
                        subindex -= 1
                    }
                }
            }
        }
        
        copyFromMtiles()
        
    }
    func changeScore(s: Int )
    {
        score = score + s
        if(bestscore < score)
        {
            bestscore = score
        }
        
        scoreDelegate.changeScore(value: score)
        bestscoreDelegate.changeScore(value: bestscore)
        
    }
    
    func mergeUP()
    {
        copyToMtiles()
        
        var index: Int
        for var i = dimension-1; i>0; i--
        {
            for j in 0..<dimension
            {
                index = self.dimension*i + j
                if((mtiles[index] > 0) && (mtiles[index - self.dimension] == mtiles[index]))
                {
                    mtiles[index-self.dimension] = mtiles[index]*2
                    changeScore(mtiles[index]*2)
                    mtiles[index] = 0
                }
            }
        }
        
        copyFromMtiles()
    }
    
    func mergeDown()
    {
        copyToMtiles()
        
        var index: Int
        for i in 0..<dimension-1
        {
            for j in 0..<dimension
            {
                index = self.dimension*i + j
                if((mtiles[index] > 0) && (mtiles[index + self.dimension] == mtiles[index]))
                {
                    mtiles[index+self.dimension] = mtiles[index]*2
                    changeScore(mtiles[index]*2)
                    mtiles[index] = 0
                }
            }
        }
        
        copyFromMtiles()
    }
    
    func mergeLeft()
    {
        copyToMtiles()
        
        var index: Int
        for i in 0..<dimension
        {
            for var j = dimension-1; j>0; j--
            {
                index = self.dimension*i + j
                if((mtiles[index] > 0) && (mtiles[index - 1] == mtiles[index]))
                {
                    mtiles[index-1] = mtiles[index]*2
                    changeScore(mtiles[index]*2)
                    mtiles[index] = 0
                }
            }
        }
        
        copyFromMtiles()
    }
    
    func mergeRight()
    {
        copyToMtiles()
        
        var index: Int
        for i in 0..<dimension
        {
            for j in 0..<dimension-1
            {
                index = self.dimension*i + j
                if((mtiles[index] > 0) && (mtiles[index + 1] == mtiles[index]))
                {
                    mtiles[index+1] = mtiles[index]*2
                    changeScore(mtiles[index]*2)
                    mtiles[index] = 0
                }
            }
        }
        
        copyFromMtiles()
    }


    
}