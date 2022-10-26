//
//  TopRatedViewController.swift
//  Homework_4
//
//  Created by Yevhenii M on 26.10.2022.
//

import UIKit
import Alamofire

//MARK: Task 6
class TopRatedViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var topRatedTableView: UITableView!
    
    let constants = Constants()
    var arrayOfTopRatedFilms: [TopRatedResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topRatedTableView.dataSource = self
        
        AF.request("\(constants.baseUrl)/movie/top_rated?api_key=\(constants.apiKey)&language=en-US&page=1").responseDecodable(of: TopRatedModel.self) { response in
            guard let result = response.value else { return }
            self.arrayOfTopRatedFilms = result.results
            self.topRatedTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfTopRatedFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let originalTitle = arrayOfTopRatedFilms[indexPath.row].originalTitle
        let year = arrayOfTopRatedFilms[indexPath.row].releaseDate
        cell.textLabel?.text = originalTitle + " - " + year.leaveByOffset(offSet: 4)
        return cell
    }
}
