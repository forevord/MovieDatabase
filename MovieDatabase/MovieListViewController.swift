//
//  MovieListViewController.swift
//  MovieDatabase
//
//  Created by Pavel Salkevich on 13.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit
import AlamofireImage
import ICSPullToRefresh

class MovieListViewController: UICollectionViewController {
    
    var moviesArray = [Movie]()
    var latestPageNumber:UInt = 0
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        loadNextMovies() {}
        

        self.collectionView?.addInfiniteScrollingWithHandler {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                // do something in the background
                dispatch_async(dispatch_get_main_queue(), { [unowned self] in
                    self.collectionView!.reloadData()
                    self.collectionView!.infiniteScrollingView?.stopAnimating()
                    self.loadNextMovies(){}
                    })
            })
        }
    }
    
    func loadNextMovies(completionHandler: () -> Void) {
        if isLoading == true || latestPageNumber >= 1000 {
            return
        }
        
        isLoading = true
        ApiMovieManager.loadMovieList (self.latestPageNumber + 1, completionHandler: { movies, error in
            if error != nil {
                print("Error")
            } else {
                self.latestPageNumber++
                self.moviesArray.appendContentsOf(movies)
                self.collectionView?.reloadData()
                
            }
            self.isLoading = false
            completionHandler()
        })
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! MovieCollectionViewCell
        let movie = moviesArray[indexPath.row]
        cell.movieImageView.af_setImageWithURL(NSURL(string: movie.movieImageURL)!)
        cell.movieTitleLabel.text = movie.movieTitle

        return cell
    }

    
}
