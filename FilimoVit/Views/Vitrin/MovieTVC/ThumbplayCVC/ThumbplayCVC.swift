//
//  ThumbplayCVC.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/19/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit
import Kingfisher

class ThumbplayCVC: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var movieItem: Movie.MovieItem! {
        didSet {
            self.imageView.kf.setImage(with: URL(string: movieItem.imageURL))
        }
    }
    
    override func prepareForReuse() {
        self.imageView.image = UIImage()
    }
    
    class func calculateSize() -> CGSize {
        CGSize(width: 275, height: 150)
    }
}
