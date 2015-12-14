//
//  ApiMovieManager.swift
//  MovieDatabase
//
//  Created by Pavel Salkevich on 13.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit
import Alamofire

class ApiMovieManager: NSObject {
    
    internal static func loadMovieList (pageNumber:UInt, completionHandler: ([Movie], NSError?) -> Void) {
        
        Alamofire.request(.GET, Constants.apiBaseURL + "/discover/movie", parameters: ["api_key":Constants.apiKEY,"page":pageNumber])
                .responseJSON { response in
                    switch response.result {
                    case .Success(let JSON):
                        print(JSON)
                        
                        var movieArray = [Movie]()
                        
                        let moviesDataArray = (JSON["results"] as? NSArray) as Array?
                        for movieData in moviesDataArray! {
                            
                            let movieID = movieData["id"] as? UInt
                            let movieTitle = movieData["original_title"] as? String
                            let movieImageUrl = Constants.imageServerURL + (movieData["poster_path"] as? String)!
                            
                            let movie = Movie.init(movieID: movieID!, movieTitle: movieTitle!, movieImageURL: movieImageUrl)
                            movieArray.append(movie)
                        }
                        
                        completionHandler(movieArray, nil)
                        break
                    case .Failure(let error):
                        print(error)
                        completionHandler([], error)
                        break
                    }
                }
    }
}
