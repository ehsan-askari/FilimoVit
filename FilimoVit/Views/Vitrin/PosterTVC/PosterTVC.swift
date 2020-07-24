//
//  PosterTVC.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/18/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit
import FSPagerView

class PosterTVC: UITableViewCell {
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.forceRTL()
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.forceRTL()
        }
    }
    
    var poster: Poster? {
        didSet {
//            self.pagerView.automaticSlidingInterval = CGFloat(self.poster?.list.first?.autoPlayDuration ?? 0)
            self.pageControl.numberOfPages = self.poster?.list.count ?? 0
            self.pagerView.reloadData()
        }
    }
    
    class func calculateHeight(imageRatio: Float) -> CGFloat {
        UIScreen.main.bounds.width * CGFloat(imageRatio)
    }
}

extension PosterTVC: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return poster?.list.count ?? 0
    }
}

extension PosterTVC: FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.contentView.forceRTL()
        cell.isUserInteractionEnabled = false
        cell.imageView?.contentMode = .scaleToFill
        if let imageURL = poster?.list[index].imageURL {
            cell.imageView?.setImage(withURL:imageURL)
        }
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
}
