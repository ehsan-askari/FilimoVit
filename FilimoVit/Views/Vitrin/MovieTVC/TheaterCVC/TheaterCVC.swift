//
//  TheaterCVC.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/19/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit
import Kingfisher

class TheaterCVC: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
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
            self.coverImageView.kf.setImage(with: URL(string: movieItem.coverImageURL ?? ""))
            self.imageView.kf.setImage(with: URL(string: movieItem.imageURL))
            self.hdImageView.isHidden = !movieItem.isHD
            self.titleLabel.text = movieItem.title
            self.avgRatePercentageLabel.text = movieItem.avgRatePercentage
            self.countryLabel.text = "محصول کشور " + (movieItem.country ?? "")
            self.categoryTitleLabel.text = movieItem.categoryTitle ?? ""
            if let iR = movieItem.imdbRate {
                self.imdbRateSV.isHidden = false
                imdbRateLabel.text = String(iR)
            }else {
                self.imdbRateSV.isHidden = true
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverImageView.image = nil
        self.imageView.image = nil
        self.imdbRateSV.isHidden = true
    }
    
    class func calculateSize() -> CGSize {
        CGSize(width: 300, height: 165)
    }
    
}
