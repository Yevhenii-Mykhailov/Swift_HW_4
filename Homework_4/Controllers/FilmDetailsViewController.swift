//
//  TopRatedDetailsViewController.swift
//  Homework_4
//
//  Created by Yevhenii M on 01.11.2022.
//

import UIKit
import YouTubePlayer
import Alamofire

class FilmDetailsViewController: UIViewController {
    @IBOutlet weak var movieTitleLable: UILabel!
    @IBOutlet weak var moviewOverviewLable: UILabel!
    @IBOutlet weak var youtubePlayerView: YouTubePlayerView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    let constants = Constants()
    var topRatedMoview: TopRatedRealmResult? = nil
    var recomendationsMoview: RecomendationResult? = nil
    var movieId: String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topRatedBackdropImageUrl = constants.urlToPosterImage + (topRatedMoview?.backdropPath ?? "No image")
        let recomendationsBackdropImageUrl = constants.urlToPosterImage + (recomendationsMoview?.backdropPath ?? "No image")
        
        movieTitleLable.text = topRatedMoview?.originalTitle ?? recomendationsMoview?.originalTitle
        moviewOverviewLable.text = topRatedMoview?.overview ?? recomendationsMoview?.overview
        backgroundImageView.load(stringUrl: topRatedBackdropImageUrl)
        backgroundImageView.load(stringUrl: recomendationsBackdropImageUrl)
        
        if let videoId = movieId {
            youtubePlayerView.loadVideoID(videoId)
        }
    }
}
