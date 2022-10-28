//
//  TopRatedViewController.swift
//  Homework_4
//
//  Created by Yevhenii M on 26.10.2022.
//

import UIKit
import Alamofire

//MARK: Task 6
class TopRatedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var topRatedTableView: UITableView!
    
    let constants = Constants()
    var arrayOfTopRatedFilms: [TopRatedResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
        AF.request("\(constants.baseUrl)/movie/top_rated?api_key=\(constants.apiKey)&language=en-US&page=1").responseDecodable(of: TopRatedModel.self) { response in
            guard let result = response.value else { return }
            self.arrayOfTopRatedFilms = result.results
            self.topRatedTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTVCell", for: indexPath) as? TopRatedTVCell{
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
    
    private func setupTableView() {
        let authorNameLable = UINib(nibName: "TopRatedTVCell",bundle: nil)
        self.topRatedTableView.register(authorNameLable, forCellReuseIdentifier: "TopRatedTVCell")
        
        topRatedTableView.dataSource = self
        topRatedTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfTopRatedFilms.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        320
    }
}
