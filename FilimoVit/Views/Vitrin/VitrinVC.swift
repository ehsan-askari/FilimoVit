//
//  VitrinVC.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/16/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VitrinVC: UIViewController {
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefreshControl),
                                 for: .valueChanged)
        refreshControl.tintColor = Color.gray
        return refreshControl
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.color = Color.gray
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.register(UINib(nibName: String(describing: PosterTVC.self), bundle: nil), forCellReuseIdentifier: String(describing: PosterTVC.self))
            self.tableView.register(UINib(nibName: String(describing: MovieTVC.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTVC.self))
            if #available(iOS 10.0, *) {
                self.tableView.refreshControl = self.refreshControl
            } else {
                self.tableView.addSubview(self.refreshControl)
            }
            self.tableView.contentOffset = CGPoint(x: 0, y: -self.refreshControl.frame.size.height)
            self.tableView.tableFooterView = self.activityIndicatorView
        }
    }
    
    private var vitrinVM = VitrinVM()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        vitrinVM.getVitrinItems()
    }
    
    private func setupBindings() {
        
        vitrinVM
            .isLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (isLoading) in
                if self.vitrinVM.isFresh() {
                    if isLoading && !self.refreshControl.isRefreshing {
                        self.refreshControl.beginRefreshing()
                    }else{
                        self.refreshControl.endRefreshing()
                    }
                } else {
                    isLoading ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
        
        vitrinVM
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (message) in
                self.showAlertView(message: message)
            })
            .disposed(by: disposeBag)
        
        vitrinVM
            .indexPathsToReload
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (indexPathsToReload) in
                if let indexPathsToReload = indexPathsToReload {
                    self.tableView.reloadRows(at: self.visibleIndexPathsToReload(indexPaths: indexPathsToReload), with: .automatic)
                }else{
                    self.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    @objc func handleRefreshControl() {
        vitrinVM.refresh()
        vitrinVM.getVitrinItems()
    }
    
}

extension VitrinVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vitrinVM.totalVitrinItemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !isUnloadedCell(for: indexPath) else {
            return UITableViewCell()
        }
        
        switch vitrinVM.vitrinItems[indexPath.row] {
        case .poster(let poster):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PosterTVC.self), for: indexPath) as! PosterTVC
            cell.poster = poster
            return cell
        case .movie(let movie):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTVC.self), for: indexPath) as! MovieTVC
            cell.movie = movie
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

extension VitrinVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard !isUnloadedCell(for: indexPath) else {
            return 0
        }
        
        switch vitrinVM.vitrinItems[indexPath.row] {
        case .poster(let poster):
            return PosterTVC.calculateHeight(imageRatio: poster.list.first?.imageRatio ?? 0.33)
        case .movie(let movie):
            return MovieTVC.calculateHeight(theme: movie.theme)
        default:
            return 0
        }
    }
    
}

extension VitrinVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if !vitrinVM.isFinished() && !activityIndicatorView.isAnimating && indexPaths.contains(where: isUnloadedCell) {
            vitrinVM.getVitrinItems()
        }
    }
    
}

private extension VitrinVC {
    
    func isUnloadedCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= vitrinVM.vitrinItems.count
    }
    
    func visibleIndexPathsToReload(indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
}

