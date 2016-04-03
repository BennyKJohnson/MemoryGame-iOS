//
//  ViewController.swift
//  MemoryGame
//
//  Created by Benjamin Johnson on 3/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func getImages() -> [UIImage] {
        return [UIImage(named: "baldhill")!, UIImage(named: "cathedral")!, UIImage(named: "lake")!]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameModel = GameModel(numberOfTiles: 8, images: getImages())
        print(gameModel)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

