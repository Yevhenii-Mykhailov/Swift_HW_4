//
//  RecomendationsViewController.swift
//  Homework_4
//
//  Created by Yevhenii M on 26.10.2022.
//

import UIKit
import Alamofire

class RecomendationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var recomendationsTableView: UITableView!
    
    let constants = Constants()
    var arrayOfRecomendations: [RecomendationResult] = []
    var arrayOfVideos: [VideosResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        AF.request("\(constants.baseUrl)/movie/\(String(constants.moovieId))/recommendations?api_key=\(constants.apiKey)&language=en-US&page=1")
            .responseDecodable(of: RecomendationsModel.self) { response in
                guard let result = response.value else { return }
                self.arrayOfRecomendations = result.results
                self.recomendationsTableView.reloadData()
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let topRatedDetailsVC = storyboard.instantiateViewController(withIdentifier: "FilmDetailsViewController") as? FilmDetailsViewController else { return }
        topRatedDetailsVC.recomendationsMoview = arrayOfRecomendations[indexPath.row]
        
        let movieId = arrayOfRecomendations[indexPath.row].id
        AF.request("\(constants.urlToVideo)/\(movieId)/videos?api_key=\(constants.apiKey)").responseDecodable(of: VideosModel.self) { response in
            guard let resultData = response.value else { return }
            let videos = resultData.results
            for video in videos {
                if video.type == "Trailer" && video.official == true {
                    topRatedDetailsVC.movieId = video.key
                    topRatedDetailsVC.reloadInputViews()
                }
            }
            
            self.present(topRatedDetailsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell", for: indexPath) as? FilmTableViewCell{
            let currentRow = indexPath.row
            let urlToPosterImage = constants.urlToPosterImage + arrayOfRecomendations[indexPath.row].posterPath
            cell.originalTitle = arrayOfRecomendations[currentRow].originalTitle
            cell.popularity = String(arrayOfRecomendations[indexPath.row].popularity)
            cell.releaseDate = arrayOfRecomendations[indexPath.row].releaseDate.leaveByOffset(offSet: 4)
            cell.filmOverviewText = arrayOfRecomendations[indexPath.row].overview
            cell.posterImageView.load(stringUrl: urlToPosterImage)
            return cell
        }
        
        return UITableViewCell()
    }
    
    private func setupTableView() {
        let authorNameLable = UINib(nibName: "FilmTableViewCell",bundle: nil)
        self.recomendationsTableView.register(authorNameLable, forCellReuseIdentifier: "FilmTableViewCell")
        
        recomendationsTableView.dataSource = self
        recomendationsTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfRecomendations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        320
    }
}
