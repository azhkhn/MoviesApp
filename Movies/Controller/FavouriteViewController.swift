//
//  FavouriteViewController.swift
//  Movies
//
//  Created by Omar Thamri on 14/11/2019.
//  Copyright © 2019 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    let FavoriteMoviesCellId = "FavoriteMoviesCellId"
    var movies = [Movie(name: "Hunger Games",imageName: "hunger_games"),Movie(name: "Hangover",imageName: "Hangover")]
    var tvseries = [Movie(name: "Vikings",imageName: "vikings"),Movie(name: "Suits",imageName: "suits"),Movie(name: "Game Of Thrones",imageName: "Game_of_Thrones"),Movie(name: "La casa de papel",imageName: "La_Casa")]
    lazy var FavoriteMoviesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let tclc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tclc.delegate = self
        tclc.dataSource = self
        tclc.translatesAutoresizingMaskIntoConstraints = false
        tclc.backgroundColor = UIColor.init(white: 0.2, alpha: 1)
        return tclc
    }()
    var choice = 0
    var selectedItem: Int?
    var leftAnchor: NSLayoutConstraint?
    var rightAnchor: NSLayoutConstraint?
    var logoutTopAnchor: NSLayoutConstraint?
    var alphaViewTopAnchor: NSLayoutConstraint?
    lazy var navDrawerView : NavDrawerView = {
        let ndv = NavDrawerView()
        ndv.translatesAutoresizingMaskIntoConstraints = false
        ndv.favouriteViewController = self
        return ndv
    }()
    lazy var closeDrawerView : CloseDrawerView = {
        let ndv = CloseDrawerView()
        ndv.translatesAutoresizingMaskIntoConstraints = false
        let viewTapped = UITapGestureRecognizer(target: self, action: #selector(closeNavDrawer))
        ndv.isUserInteractionEnabled = true
        ndv.addGestureRecognizer(viewTapped)
        return ndv
    }()
    
    let choiceView: UIView = {
        let cv = UIView()
        cv.backgroundColor = UIColor.init(white: 0.25, alpha: 1)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let moviesBtn: UIButton = {
        let mb = UIButton()
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.setTitle(NSLocalizedString("Movies", comment: ""), for: .normal)
        mb.setTitleColor(UIColor.white, for: .normal)
        mb.titleLabel?.textAlignment = .center
        mb.addTarget(self, action: #selector(movieTapped), for: .touchUpInside)
        return mb
    }()
    
    lazy var tvSeriesBtn: UIButton = {
        let mb = UIButton()
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.setTitle(NSLocalizedString("TV Series", comment: ""), for: .normal)
        mb.setTitleColor(UIColor.white, for: .normal)
        mb.titleLabel?.textAlignment = .center
        mb.addTarget(self, action: #selector(tvSerieTapped), for: .touchUpInside)
        return mb
    }()
    
    let whiteLine: UIView = {
       let wl = UIView()
        wl.backgroundColor = UIColor.white
        wl.translatesAutoresizingMaskIntoConstraints = false
        return wl
    }()
    
    let TvSerieWhiteLine: UIView = {
        let wl = UIView()
        wl.backgroundColor = UIColor.white
        wl.translatesAutoresizingMaskIntoConstraints = false
        wl.isHidden = true
        return wl
    }()
    
    var widthNavDrawer: CGFloat?
    var widthCloseNavDrawer: CGFloat?
    
    let currentWindow: UIWindow? = UIApplication.shared.keyWindow
    let alphaView: UIView = {
        let av = UIView()
        av.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        av.translatesAutoresizingMaskIntoConstraints = false
        return av
    }()
    lazy var logoutView: LogoutView = {
        let lv = LogoutView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.favouriteViewController = self
        return lv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupNavigationBar()
    }
    
    func setupView() {
        view.addSubview(FavoriteMoviesCV)
        FavoriteMoviesCV.register(FavouriteMovieCell.self, forCellWithReuseIdentifier: FavoriteMoviesCellId)
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = NSLocalizedString("Favorite", comment: "")
        view.backgroundColor = UIColor.init(white: 0.2, alpha: 1)
        currentWindow?.addSubview(navDrawerView)
        currentWindow?.addSubview(closeDrawerView)
        view.addSubview(choiceView)
        choiceView.addSubview(moviesBtn)
        choiceView.addSubview(whiteLine)
        choiceView.addSubview(tvSeriesBtn)
        choiceView.addSubview(TvSerieWhiteLine)
        setupLogoutView()
    }
    
    func setupConstraints() {
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":choiceView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-64-[v0(75)]-20-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":choiceView,"v1":FavoriteMoviesCV]))
        choiceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0(\(view.frame.width/2))]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":moviesBtn]))
        choiceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-1-[v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":moviesBtn,"v1":whiteLine]))
        choiceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0(\(view.frame.width/2))]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":whiteLine]))
        choiceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(\(view.frame.width/2))]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":tvSeriesBtn]))
        choiceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-1-[v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":tvSeriesBtn,"v1":TvSerieWhiteLine]))
        choiceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(\(view.frame.width/2))]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":TvSerieWhiteLine]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":FavoriteMoviesCV]))
        widthNavDrawer = (currentWindow?.frame.width)! * 2 / 3
        widthCloseNavDrawer = (currentWindow?.frame.width)! / 3
        navDrawerView.widthAnchor.constraint(equalToConstant: widthNavDrawer!).isActive = true
        navDrawerView.heightAnchor.constraint(equalTo: (currentWindow?.heightAnchor)!).isActive = true
        leftAnchor = navDrawerView.leftAnchor.constraint(equalTo: (currentWindow?.leftAnchor)!,constant: -widthNavDrawer!)
        leftAnchor?.isActive = true
        navDrawerView.topAnchor.constraint(equalTo: (currentWindow?.topAnchor)!).isActive = true
        closeDrawerView.widthAnchor.constraint(equalToConstant: widthCloseNavDrawer!).isActive = true
        closeDrawerView.heightAnchor.constraint(equalTo: (currentWindow?.heightAnchor)!).isActive = true
        rightAnchor = closeDrawerView.rightAnchor.constraint(equalTo: (currentWindow?.rightAnchor)!,constant: widthCloseNavDrawer!)
        rightAnchor?.isActive = true
        closeDrawerView.topAnchor.constraint(equalTo: (currentWindow?.topAnchor)!).isActive = true
        setupLogoutViewConstraints()
    }
    
    func setupNavigationBar() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(showNavigationDrawer))
        leftBarButtonItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func tvSerieTapped() {
        whiteLine.isHidden = true
        TvSerieWhiteLine.isHidden = false
        choice = 1
        FavoriteMoviesCV.reloadData()
    }
    @objc func movieTapped() {
        TvSerieWhiteLine.isHidden = true
        whiteLine.isHidden = false
        choice = 0
        FavoriteMoviesCV.reloadData()
    }
    @objc func showNavigationDrawer() {
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
        leftAnchor?.constant = 0
        rightAnchor?.constant = 0
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.currentWindow?.layoutIfNeeded()
            self.currentWindow?.updateConstraints()
            self.currentWindow?.setNeedsLayout()
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
        })
        
    }
    
    @objc func closeNavDrawer() {
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
        leftAnchor?.constant = -widthNavDrawer!
        rightAnchor?.constant = widthCloseNavDrawer!
        self.currentWindow?.layoutIfNeeded()
        if selectedItem == 0 {
            let homeViewContoller = HomeViewController()
            navigationController?.pushViewController(homeViewContoller, animated: false)
        } else if selectedItem == 1 {
            let moviesViewController = MoviesViewController()
            navigationController?.pushViewController(moviesViewController, animated: false)
        } else if selectedItem == 2 {
            let tvSerieListViewController = TvSerieListViewController()
            navigationController?.pushViewController(tvSerieListViewController, animated: false)
        } else if selectedItem == 3 {
            let favouriteViewController = FavouriteViewController()
            navigationController?.pushViewController(favouriteViewController, animated: false)
        }else if selectedItem == 4 {
            let profileViewController = ProfileViewController()
            navigationController?.pushViewController(profileViewController, animated: false)
        } else if selectedItem == 5 {
            let settingsViewController = SettingsViewController()
            navigationController?.pushViewController(settingsViewController, animated: false)
        } else if selectedItem == 6 {
            alphaViewTopAnchor?.constant = 0
            logoutTopAnchor?.constant = 0
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                self.currentWindow?.layoutIfNeeded()
            })
        }
    }
    
    func setupLogoutView() {
        currentWindow?.addSubview(alphaView)
        currentWindow?.addSubview(logoutView)
    }
    
    func setupLogoutViewConstraints() {
        currentWindow?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":alphaView]))
        alphaViewTopAnchor = alphaView.topAnchor.constraint(equalTo: (currentWindow?.topAnchor)!, constant: (currentWindow?.frame.height)!)
        alphaViewTopAnchor?.isActive = true
        alphaView.heightAnchor.constraint(equalTo: (currentWindow?.heightAnchor)!).isActive = true
        currentWindow?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":logoutView]))
        logoutView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoutTopAnchor = logoutView.centerYAnchor.constraint(equalTo: (currentWindow?.centerYAnchor)!, constant: (currentWindow?.frame.height)! )
        logoutTopAnchor?.isActive = true
    }
    
    func Logout() {
        alphaViewTopAnchor?.constant = (currentWindow?.frame.height)!
        logoutTopAnchor?.constant = (currentWindow?.frame.height)!
        self.currentWindow?.layoutIfNeeded()
        let signInViewController = SignInViewController()
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(signInViewController, animated: false)
    }
    
    func cancelLogout() {
        alphaViewTopAnchor?.constant = (currentWindow?.frame.height)!
        logoutTopAnchor?.constant = (currentWindow?.frame.height)!
        self.currentWindow?.layoutIfNeeded()
    }
    
}

extension FavouriteViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if choice == 1 {
            return tvseries.count
        }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if choice == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMoviesCellId, for: indexPath) as! FavouriteMovieCell
            cell.movie = tvseries[indexPath.item]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMoviesCellId, for: indexPath) as! FavouriteMovieCell
        cell.movie = movies[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/3) - 10, height: (collectionView.frame.height * 0.38))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    
    
}

