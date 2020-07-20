//
//  SerialImageView.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/20/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit

class SerialImageView: UIView {
    
    @IBOutlet weak var firstImageView: UIImageView! {
        didSet {
            self.firstImageView.addBlurEffect(alpha: 0.5)
        }
    }
    
    @IBOutlet weak var secondImageView: UIImageView! {
        didSet {
            self.secondImageView.addBlurEffect(alpha: 0.8)
        }
    }
    
    @IBOutlet weak var thirdImageView: UIImageView!
    
    var imageURL: String = "" {
        didSet {
            self.firstImageView.setImage(withURL: self.imageURL)
            self.secondImageView.setImage(withURL: self.imageURL)
            self.thirdImageView.setImage(withURL: self.imageURL)
        }
    }
    
}
