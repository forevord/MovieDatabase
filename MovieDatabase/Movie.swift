//
//  Movie.swift
//  MovieDatabase
//
//  Created by Pavel Salkevich on 13.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit

class Movie: NSObject {
    
    private(set) var movieTitle: String = ""
    private(set) var movieImageURL: String = ""
    private(set) var movieID: UInt = 0
    
    init(movieID:UInt, movieTitle:String, movieImageURL:String) {
        self.movieID = movieID
        self.movieImageURL = movieImageURL
        self.movieTitle = movieTitle
    }
    
    override var description: String {
        return "id=\(self.movieID), title=\(self.movieTitle), imageURL=\(self.movieImageURL)"
    }
}
