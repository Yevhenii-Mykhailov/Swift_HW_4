//
//  TopRatedDetailsViewController.swift
//  Homework_4
//
//  Created by Yevhenii M on 01.11.2022.
//

import UIKit
import YouTubePlayer
import Alamofire

class TopRatedDetailsViewController: UIViewController {
    @IBOutlet weak var movieTitleLable: UILabel!
    @IBOutlet weak var moviewOverviewLable: UILabel!
    @IBOutlet weak var youtubePlayerView: YouTubePlayerView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    let constants = Constants()
    var topRatedMoview: TopRatedResult? = nil
    var movieId: String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backdropImageUrl = constants.urlToPosterImage + (topRatedMoview?.backdropPath ?? "No image")
        
        movieTitleLable.text = topRatedMoview?.originalTitle
        moviewOverviewLable.text = topRatedMoview?.overview
        backgroundImageView.load(stringUrl: backdropImageUrl)
        
        if let videoId = movieId {
            youtubePlayerView.loadVideoID(videoId)
        }
    }
}
