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

class TopRatedViewController: UIViewController {
    @IBOutlet weak var topRatedTableView: UITableView!
    
    let realm = try! Realm()
    let constants = Constants()
    var arrayOfTopRatedFilms: [TopRatedRealmResult] = []
    var arrayOfTopRatedFilmsRealm = TopRatedModel.create(page: 0, results: [], totalPages: 0, totalResults: 0)
    var arrayOfVideos: [VideosResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
        AF.request("\(constants.baseUrl)/movie/top_rated?api_key=\(constants.apiKey)&language=en-US&page=1").responseDecodable(of: TopRatedModel.self) { response in
            guard let result = response.value else { return }
            self.arrayOfTopRatedFilmsRealm = result
            self.addTopRatedFilmsToRealm(self.arrayOfTopRatedFilmsRealm)
            
            let filmsFromRealm = self.getTopRatedFilmsFromRealm().results
            for film in filmsFromRealm {
                self.arrayOfTopRatedFilms.append(film)
                self.topRatedTableView.reloadData()
            }
        }
    }
    
    private func addTopRatedFilmsToRealm(_ filmResults: TopRatedModel) {
        let topRatedFilms = filmResults
        
        try! realm.write({
            realm.add(topRatedFilms)
        })
    }

    private func getTopRatedFilmsFromRealm() -> TopRatedModel {
        let topRateFilms = realm.objects(TopRatedModel.self)
        
        //index=0 - page0, index=1 = page1 ....
//        for (index, film) in topRateFilms.enumerated() {
//            print(index)
//            print(film)
//        }
        if let result = topRateFilms.first {
            return result
        }
        
        return TopRatedModel ()
        
    }
    
    private func setupTableView() {
        let authorNameLable = UINib(nibName: "FilmTableViewCell",bundle: nil)
        self.topRatedTableView.register(authorNameLable, forCellReuseIdentifier: "FilmTableViewCell")
        
        topRatedTableView.dataSource = self
        topRatedTableView.delegate = self
    }
    
    private func deleteOldDb() {
        do {
            // Delete the realm if a migration would be required, instead of migrating it.
            // While it's useful during development, do not leave this set to `true` in a production app!
            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: configuration)
        } catch {
            print("Error opening realm: \(error.localizedDescription)")
        }
    }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell", for: indexPath) as? FilmTableViewCell{
            let currentRow = indexPath.row
            let urlToPosterImage = constants.urlToPosterImage + arrayOfTopRatedFilms[indexPath.row].posterPath
            cell.originalTitle = arrayOfTopRatedFilms[currentRow].originalTitle
            cell.popularity = String(arrayOfTopRatedFilms[indexPath.row].popularity)
            cell.releaseDate = arrayOfTopRatedFilms[indexPath.row].releaseDate.leaveByOffset(offSet: 4)
            cell.filmOverviewText = arrayOfTopRatedFilms[indexPath.row].overview
            cell.posterImageView.load(stringUrl: urlToPosterImage)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfTopRatedFilms.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        320
    }
}
