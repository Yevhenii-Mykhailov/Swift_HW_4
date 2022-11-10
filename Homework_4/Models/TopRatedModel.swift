//
//  TopRatedRealmModel.swift
//  Homework_4
//
//  Created by Yevhenii M on 06.11.2022.
//

import Foundation
import RealmSwift

class TopRatedModel: Object, Decodable {
    @objc dynamic var page: Int  = 0
    var results = List<TopRatedRealmResult>()
    @objc dynamic var totalPages: Int = 0
    @objc dynamic var totalResults: Int = 0
    
    static func create(page: Int, results: [TopRatedRealmResult], totalPages: Int, totalResults: Int) -> TopRatedModel {
        let topRatedRealmModel = TopRatedModel()
        topRatedRealmModel.page = page
        topRatedRealmModel.totalPages = totalPages
        topRatedRealmModel.totalResults = totalResults
        topRatedRealmModel.results.append(objectsIn: results)
        
        return topRatedRealmModel
    }
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

class TopRatedRealmResult: EmbeddedObject, Decodable {
    @objc dynamic var adult: Bool
    @objc dynamic var backdropPath: String
    var genreIDS: [Int]
    @objc dynamic var id: Int
    @objc dynamic var originalLanguage: String
    @objc dynamic var originalTitle: String
    @objc dynamic var overview: String
    @objc dynamic var popularity: Double
    @objc dynamic var posterPath: String
    @objc dynamic var releaseDate: String
    @objc dynamic var title: String
    @objc dynamic var video: Bool
    @objc dynamic var voteAverage: Double
    @objc dynamic var voteCount: Int
    
    static func create(adult: Bool,
                       backdropPath: String,
                       genreIDS: [Int],
                       id: Int,
                       originalLanguage: String,
                       originalTitle: String,
                       overview: String,
                       popularity: Double,
                       posterPath: String,
                       releaseDate: String,
                       title: String,
                       video: Bool,
                       voteAverage: Double,
                       voteCount: Int) -> TopRatedRealmResult {
        let topRatedRealmResult = TopRatedRealmResult()
        topRatedRealmResult.adult = adult
        topRatedRealmResult.backdropPath = backdropPath
        topRatedRealmResult.genreIDS = genreIDS
        topRatedRealmResult.id = id
        topRatedRealmResult.originalTitle = originalTitle
        topRatedRealmResult.originalLanguage = originalLanguage
        topRatedRealmResult.overview = overview
        topRatedRealmResult.popularity = popularity
        topRatedRealmResult.posterPath = posterPath
        topRatedRealmResult.releaseDate = releaseDate
        topRatedRealmResult.title = title
        topRatedRealmResult.video = video
        topRatedRealmResult.voteAverage = voteAverage
        topRatedRealmResult.voteCount = voteCount
        
        return topRatedRealmResult
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
}
