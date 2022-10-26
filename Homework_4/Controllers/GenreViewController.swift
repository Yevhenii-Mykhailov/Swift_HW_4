//
//  GenreTableViewController.swift
//  Homework_4
//
//  Created by Yevhenii M on 26.10.2022.
//

import UIKit
import Alamofire

//MARK: Task 6
class GenreViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var genreTableView: UITableView!
    
    let constants = Constants()
    var arrayOfGenre: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genreTableView.dataSource = self
        
        AF.request("\(constants.baseUrl)/genre/movie/list?api_key=\(constants.apiKey)")
            .responseDecodable(of: GenreModel.self) { response in
                guard let result = response.value else { return }
                self.arrayOfGenre = result.genres
                self.genreTableView.reloadData()
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfGenre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.arrayOfGenre[indexPath.row].name
        return cell
    }
}
