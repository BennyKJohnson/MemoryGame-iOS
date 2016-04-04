//
//  TileView.swift
//  MemoryGame
//
//  Created by Benjamin Johnson on 3/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import UIKit

protocol TileViewDelegate {
    func didSelectTile(tileView: TileView)
}

class TileView: UIView {

    var imageView: UIImageView!
    
    var image: UIImage!
    
    var tileIndex: Int = -1
    
    var delegate: TileViewDelegate?
    
    var tileIsHidden: Bool = false
    
    func revealImage() {
        imageView.image = image
        
    }
    
    func coverImage() {
        imageView.image = UIImage(named: "question")

    }
    
    func hide() {
        imageView.image = nil
        tileIsHidden = true
        // Remove gestured Recogniser
        
    }
    
    func didTap() {
        delegate?.didSelectTile(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Add ImageView
        imageView = UIImageView(frame: CGRectMake(0,0,0,0))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        
        // Setup Constraints
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        let leftConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0)
        let rightConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0)
        // Add Constraints
        self.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        
        let touch = UITapGestureRecognizer(target:self, action:"didTap")
        self.addGestureRecognizer(touch)


    }
    
}
