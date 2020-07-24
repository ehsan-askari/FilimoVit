//
//  MovieTVC.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/19/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit
import FSPagerView

class MovieTVC: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.forceRTL()
            
            self.collectionView.register(UINib(nibName: String(describing: ThumbplayCVC.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ThumbplayCVC.self))
            self.collectionView.register(UINib(nibName: String(describing: ThumbnailCVC.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ThumbnailCVC.self))
            self.collectionView.register(UINib(nibName: String(describing: TheaterCVC.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TheaterCVC.self))
            
        }
    }
    
    var movie: Movie! {
        didSet {
            if self.movie.title.isEmpty {
                self.titleView.isHidden = true
            } else {
                self.titleLabel.text = self.movie.title
            }
            self.collectionView.reloadData()
        }
    }
    
    class func calculateHeight(theme: VitrinItemTheme) -> CGFloat {
        var height: CGFloat = 0
        switch theme {
        case .Thumbplay:
            height = ThumbplayCVC.calculateSize().height
        case .Thumbnail:
            height = ThumbnailCVC.calculateSize().height
        case .Theater:
            height = TheaterCVC.calculateSize().height
        default:
            return 0
        }
        return height + 75
    }
}

extension MovieTVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch movie.theme {
        case .Thumbplay:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ThumbplayCVC.self), for: indexPath) as! ThumbplayCVC
            cell.movieItem = movie.list[indexPath.row]
            cell.contentView.forceRTL()
            return cell
        case .Thumbnail:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ThumbnailCVC.self), for: indexPath) as! ThumbnailCVC
            cell.movieItem = movie.list[indexPath.row]
            cell.contentView.forceRTL()
            return cell
        case .Theater:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TheaterCVC.self), for: indexPath) as! TheaterCVC
            cell.movieItem = movie.list[indexPath.row]
            cell.contentView.forceRTL()
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
}

extension MovieTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch movie.theme {
        case .Thumbplay:
            return ThumbplayCVC.calculateSize()
        case .Thumbnail:
            return ThumbnailCVC.calculateSize()
        case .Theater:
            return TheaterCVC.calculateSize()
        default:
            return CGSize.zero
        }
    }
}

