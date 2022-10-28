//
//  RecomendationsViewController.swift
//  Homework_4
//
//  Created by Yevhenii M on 26.10.2022.
//

import UIKit
import Alamofire

//MARK: Task 6
class RecomendationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var recomendationsTableView: UITableView!
    
    let constants = Constants()
    var arrayOfRecomendations: [RecomendationResult] = []
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTVCell", for: indexPath) as? TopRatedTVCell{
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
        let authorNameLable = UINib(nibName: "TopRatedTVCell",bundle: nil)
        self.recomendationsTableView.register(authorNameLable, forCellReuseIdentifier: "TopRatedTVCell")
        
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
