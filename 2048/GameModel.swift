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
    
    init(dimension: Int){
        self.dimension = dimension
        
        initTiles()
        
    }
    
    func initTiles()
    {
        self.tiles = Array<Int>(count: self.dimension*self.dimension, repeatedValue: 0)
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
    
}