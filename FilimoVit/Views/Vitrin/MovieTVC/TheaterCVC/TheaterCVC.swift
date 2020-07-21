//
//  TheaterCVC.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/19/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit

class TheaterCVC: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView! {
        didSet {
            self.coverImageView.addBlurEffect(alpha: 0.5)
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hdImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avgRatePercentageLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var imdbRateSV: UIStackView!
    @IBOutlet weak var imdbRateLabel: UILabel!
    
    var movieItem: Movie.MovieItem! {
        didSet {
            self.coverImageView.setImage(withURL: movieItem.coverImageURL ?? "")
            self.imageView.setImage(withURL: movieItem.imageURL)
            self.hdImageView.isHidden = !movieItem.isHD
            self.titleLabel.text = movieItem.title
            self.avgRatePercentageLabel.text = movieItem.avgRatePercentage
            self.countryLabel.text = "محصول کشور " + (movieItem.country ?? "")
            self.categoryTitleLabel.text = movieItem.categoryTitle ?? ""
            if let iR = movieItem.imdbRate {
                self.imdbRateSV.isHidden = false
                imdbRateLabel.text = String(iR)
            }
        }
    }
    
    override func prepareForReuse() {
        self.coverImageView.image = UIImage()
        self.imageView.image = UIImage()
        self.imdbRateSV.isHidden = true
    }
}
