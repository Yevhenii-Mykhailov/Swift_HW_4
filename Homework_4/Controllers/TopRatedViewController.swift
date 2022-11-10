//
//  TopRatedViewController.swift
//  Homework_4
//
//  Created by Yevhenii M on 26.10.2022.
//

import UIKit
import Alamofire
import SwiftUI
import RealmSwift

//TODO: Error when load more then 19 films
class TopRatedViewController: UIViewController {
    @IBOutlet weak var topRatedTableView: UITableView!
    
    let realm = try! Realm()
    let constants = Constants()
    var arrayOfTopRatedFilms: [TopRatedRealmResult] = []
    var arrayOfTopRatedFilmsRealm = TopRatedModel.create(page: 0, results: [], totalPages: 0, totalResults: 0)
    var arrayOfVideos: [VideosResults] = []
    var pageNumber = 1
    
    var isPaginationOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
        getFilmsFromSource(pageNumber)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        if pos > topRatedTableView.contentSize.height - 320 - scrollView.frame.size.height{
            if !isPaginationOn {
                pageNumber += 1
                getFilmsFromSource(pageNumber)
            } else{
                return
            }
        }
    }
    
    private func setupTableView() {
        topRatedTableView.dataSource = self
        topRatedTableView.delegate = self
        
        let filmCellNib = UINib(nibName: "FilmTableViewCell",bundle: nil)
        self.topRatedTableView.register(filmCellNib, forCellReuseIdentifier: "FilmTableViewCell")
    }
    
    private func getFilmsFromSource(_ pageNumber: Int) {
        AF.request("\(constants.baseUrl)/movie/top_rated?api_key=\(constants.apiKey)&language=en-US&page=\(pageNumber)").responseDecodable(of: TopRatedModel.self) { response in
            guard let result = response.value else { return }
            self.arrayOfTopRatedFilmsRealm = result
            self.addTopRatedFilmsToRealm(self.arrayOfTopRatedFilmsRealm)
            self.getFilmsFromDbModel(dbModel: self.getFilmsByPage(pageNumber))
            self.topRatedTableView.reloadData()
        }
    }
    
    private func getFilmsFromDbModel(dbModel: TopRatedModel) {
        let filmsFromRealm = dbModel.results
        self.arrayOfTopRatedFilms.append(contentsOf: (0...19).map { index in filmsFromRealm[index]})
    }
    
    private func getFilmsByPage(_ pageNumber: Int) -> TopRatedModel {
        let realmObject = realm.objects(TopRatedModel.self)
        let ralmQuery = realmObject.where {
            ($0.page == pageNumber)
        }
        guard let result = ralmQuery.first else { return TopRatedModel() }
        
        return result
    }
    
    private func addTopRatedFilmsToRealm(_ filmResults: TopRatedModel) {
        let topRatedFilms = filmResults
        
        try! realm.write({
            realm.add(topRatedFilms)
        })
    }
    
    
    
    
    
    //po Realm.Configuration.defaultConfiguration.fileURL
}

extension TopRatedViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let topRatedDetailsVC = storyboard.instantiateViewController(withIdentifier: "FilmDetailsViewController") as? FilmDetailsViewController else { return }
        topRatedDetailsVC.topRatedMoview = arrayOfTopRatedFilms[indexPath.row]
        
        let movieId = arrayOfTopRatedFilms[indexPath.row].id
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfTopRatedFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = topRatedTableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell", for: indexPath) as? FilmTableViewCell {
            
            let currentRow = indexPath.row
            let urlToPosterImage = constants.urlToPosterImage + arrayOfTopRatedFilms[indexPath.row].posterPath
            cell.originalTitle = arrayOfTopRatedFilms[currentRow].originalTitle
            cell.popularity = String(arrayOfTopRatedFilms[indexPath.row].popularity)
            cell.releaseDate = arrayOfTopRatedFilms[indexPath.row].releaseDate.leaveByOffset(offSet: 4)
            cell.filmOverviewText = arrayOfTopRatedFilms[indexPath.row].overview
            cell.posterImageView.load(stringUrl: urlToPosterImage)
            
            print(cell.originalTitle + " " + "\(currentRow)")
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        320
    }
}
