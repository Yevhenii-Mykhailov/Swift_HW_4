//
//  RecomendationsViewController.swift
//  Homework_4
//
//  Created by Yevhenii M on 26.10.2022.
//

import UIKit
import Alamofire

//MARK: Task 6
class RecomendationsViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var recomendationsTableView: UITableView!
    
    let constants = Constants()
    var arrayOfRecomendations: [RecomendationResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recomendationsTableView.dataSource = self
        
        AF.request("\(constants.baseUrl)/movie/\(String(constants.moovieId))/recommendations?api_key=\(constants.apiKey)&language=en-US&page=1")
            .responseDecodable(of: RecomendationsModel.self) { response in
                guard let result = response.value else { return }
                self.arrayOfRecomendations = result.results
                self.recomendationsTableView.reloadData()
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfRecomendations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let originalTitle = arrayOfRecomendations[indexPath.row].originalTitle
        let year = arrayOfRecomendations[indexPath.row].releaseDate
        cell.textLabel?.text = originalTitle + " - " + year.leaveByOffset(offSet: 4)
        return cell
    }
}
