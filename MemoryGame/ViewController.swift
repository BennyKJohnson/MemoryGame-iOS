//
//  ViewController.swift
//  MemoryGame
//
//  Created by Benjamin Johnson on 3/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TileViewDelegate {

    @IBOutlet weak var scoreLabel: UILabel!
    
    var gameModel: GameModel!
    
    var tileViews: [TileView] = []
    
    let numberOfTiles = 12
    
    func getImages() -> [UIImage] {
        return [UIImage(named: "baldhill")!, UIImage(named: "cathedral")!, UIImage(named: "lake")!]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameModel = GameModel(numberOfTiles: numberOfTiles, images: getImages())
        gameModel.delegate = self
        
        setupTiles()
      
    }
    
    func setupTiles() {
        tileViews = []
        for i in 0..<numberOfTiles {
            let tileView = self.view.viewWithTag(i+1) as! TileView
            tileViews.append(tileView)
            let tileData = gameModel.tiles[i]
            tileView.image = tileData.image
            tileView.tileIndex = i
            tileView.delegate = self
            tileView.tileIsHidden = false
            tileView.coverImage()
        }
    }
    
    func resetGame() {
       
        gameModel.reset(numberOfTiles, images: getImages())
        setupTiles()
    }
    
    func didSelectTile(tileView: TileView) {
        if !tileView.tileIsHidden {
            gameModel.pushTileIndex(tileView.tileIndex)
            tileView.revealImage()

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: GameModelDelegate {
    
    func gameDidComplete(gameModel: GameModel) {
        
        let alert = UIAlertController(title: "Game Finished", message: "You scored \(gameModel.score)", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (_) in
            self.resetGame()
        }
        alert.addAction(okAction)
        self.showViewController(alert, sender: self)
    }
    
    func didMatchTile(gameModel: GameModel, tileIndex: Int, previousTileIndex: Int) {
        dispatchAfter(1.0) {
            self.tileViews[tileIndex].hide()
            self.tileViews[previousTileIndex].hide()
        }
  
        
    }
    
    
    func didFailToMatchTile(gameModel: GameModel, tileIndex: Int, previousTileIndex: Int) {
        
        dispatchAfter(1.0) {
            self.tileViews[tileIndex].coverImage()
            self.tileViews[previousTileIndex].coverImage()
        }
    }
    
    func scoreDidUpdate(gameModel: GameModel, newScore: Int) {
        scoreLabel.text = "Score: \(newScore)"
    }
    
}

