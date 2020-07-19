//
//  ImageSliderTVC.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/18/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit
import FSPagerView


class ImageSliderTVC: UITableViewCell {
    
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
    
    var headerSlider: HeaderSlider! {
        didSet {
            self.pageControl.numberOfPages = self.headerSlider.list.count
            pagerView.reloadData()
        }
    }
    
    class func calculateHeight() -> CGFloat {
        UIScreen.main.bounds.width / 1.75
    }
}

extension ImageSliderTVC: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return headerSlider.list.count
    }
}

extension ImageSliderTVC: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.forceRTL()
        cell.isUserInteractionEnabled = false
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.setImage(withURL: headerSlider.list[index].imageURL)
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
}
