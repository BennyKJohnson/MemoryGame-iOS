//
//  GameModel.swift
//  MemoryGame
//
//  Created by Benjamin Johnson on 3/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import UIKit

protocol GameModelDelegate {
    func gameDidComplete(gameModel: GameModel)
    func didMatchTile(gameModel: GameModel, tileIndex: Int, previousTileIndex:Int)
    func didFailToMatchTile(gameModel: GameModel, tileIndex: Int, previousTileIndex: Int)
    func scoreDidUpdate(gameModel: GameModel, newScore: Int)
}

class GameModel {
    
    var lastTileTappedIndex: Int?
    
    var secondLastTileTappedIndex: Int?
    
    var isSecondTurn: Bool = false
    
    var numberOfMatchedTiles: Int = 0
    
    var score: Int = 0 {
        didSet {
            delegate?.scoreDidUpdate(self, newScore: score)
        }
    }
    
    var delegate: GameModelDelegate? = nil
    
    var tiles: [TileData] = []
    
    init(numberOfTiles: Int, images: [UIImage]) {
       assert(numberOfTiles % 2 == 0, "Number of tiles is not even")
        
        reset(numberOfTiles, images: images)
    }
    
    func reset(numberOfTiles: Int, images: [UIImage]) {
        
        // Reset Properties
        lastTileTappedIndex = nil
        secondLastTileTappedIndex = nil
        isSecondTurn = false
        numberOfMatchedTiles = 0
        score = 0
        tiles = []
        
        // Populate Tiles
        var imageCounter = 0
        
        for(var i = 0; i < numberOfTiles; i = i + 2) {
            tiles.append(TileData(imageIdentifier: imageCounter, image: images[imageCounter]))
            tiles.append(TileData(imageIdentifier: imageCounter, image: images[imageCounter]))
            
            imageCounter += 1
            
            // Reset back to beginning of images
            if imageCounter == images.count {
                imageCounter = 0
            }
        }
        
        // Shuffle
        tiles = tiles.shuffle()
        
    }
    
    func  pushTileIndex(tileIndex: Int)  {
        // 1 Move
        secondLastTileTappedIndex = lastTileTappedIndex
        lastTileTappedIndex = tileIndex
        if let secondLastTileTappedIndex = secondLastTileTappedIndex, lastTileTappedIndex = lastTileTappedIndex {
            let firstTile = tiles[secondLastTileTappedIndex]
            let secondTile = tiles[lastTileTappedIndex]
            
            if firstTile.imageIdentifier == secondTile.imageIdentifier {
                // Matched
                self.delegate?.didMatchTile(self, tileIndex: lastTileTappedIndex, previousTileIndex: secondLastTileTappedIndex)
                score += 200
                numberOfMatchedTiles += 2
                
                if(numberOfMatchedTiles == tiles.count) {
                    delegate?.gameDidComplete(self)
                }
                
            } else {
                // Mismatched
                delegate?.didFailToMatchTile(self, tileIndex: lastTileTappedIndex, previousTileIndex: secondLastTileTappedIndex)
                score -= 100
            }
            
            // Reset tapped Index
            self.lastTileTappedIndex = nil
            self.secondLastTileTappedIndex = nil
        }
        
        
    }
    
}

extension GameModel: CustomStringConvertible {
    var description: String {
        var descriptionString = ""
        for tile in tiles {
            descriptionString += "\(tile)\n"
        }
        return descriptionString
    }
}