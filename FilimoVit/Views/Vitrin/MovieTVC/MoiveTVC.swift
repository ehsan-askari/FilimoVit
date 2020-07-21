//
//  MoiveTVC.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/19/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit
import FSPagerView

class MoiveTVC: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.forceRTL()
            //            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    var movie: Movie! {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    class func calculateHeight(them: VitrinItemTheme) -> CGFloat {
        //        switch them {
        //        case .Theater:
        ////            TheatherCell - 35
        //        default:
        //
        //        }
        UIScreen.main.bounds.width * 0.35
    }
}

extension MoiveTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
}

extension MoiveTVC: UICollectionViewDelegate {}

