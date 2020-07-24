//
//  SerialImageView.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/20/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit
import Kingfisher

class SerialImageView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var firstImageView: UIImageView! {
        didSet {
            self.firstImageView.addBlurEffect(alpha: 0.7)
        }
    }
    
    @IBOutlet weak var secondImageView: UIImageView! {
        didSet {
            self.secondImageView.addBlurEffect(alpha: 0.3)
        }
    }
    
    @IBOutlet weak var thirdImageView: UIImageView!
    
    var imageURL: String! {
        didSet {
            self.firstImageView.kf.setImage(with: URL(string: imageURL))
            self.secondImageView.kf.setImage(with: URL(string: imageURL))
            self.thirdImageView.kf.setImage(with: URL(string: imageURL))
        }
    }
    
    var isSerial: Bool! {
        didSet {
            self.firstImageView.isHidden = !isSerial
            self.secondImageView.isHidden = !isSerial
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("SerialImageView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func prepareForReuse() {
        self.firstImageView.image = UIImage()
        self.secondImageView.image = UIImage()
        self.thirdImageView.image = UIImage()
    }
    
}
