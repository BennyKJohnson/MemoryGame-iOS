//
//  TitleData.swift
//  MemoryGame
//
//  Created by Benjamin Johnson on 3/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import UIKit

struct TileData {
    let imageIdentifier: Int
    let image: UIImage
}

extension TileData: CustomStringConvertible {
    var description: String {
        return "\(imageIdentifier)"
    }
}