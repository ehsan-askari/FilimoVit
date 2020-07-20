//
//  ThumbnailCVC.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/19/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit

class ThumbnailCVC: UICollectionViewCell {
    
    @IBOutlet weak var serialImageView: SerialImageView!
    @IBOutlet weak var hdImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleEnLabel: UILabel!
    
    var movieItem: Movie.MovieItem! {
        didSet {
            self.serialImageView.imageURL = movieItem.imageURL
            self.hdImageView.isHidden = !movieItem.isHD
            self.titleLabel.text = movieItem.title
            self.titleEnLabel.text = movieItem.titleEn
        }
    }
}
