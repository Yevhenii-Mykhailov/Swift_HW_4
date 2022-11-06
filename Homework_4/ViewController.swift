//
//  ViewController.swift
//  Homework_4
//
//  Created by Yevhenii M on 25.10.2022.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    var topRatedResult: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = Bundle.main.url(forResource: "rawData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: filePath)
                let jsonData = try JSONDecoder().decode(Company.self, from: data)
                print(jsonData.companyDescription)
                print(jsonData.listOfData.first?.modelNumber)
                print(jsonData.listOfData.first?.countries.last)
                print(jsonData.listOfData.last?.price.regions.first?.name)
                print(jsonData.listOfData.last?.price.regions.last?.price)
            } catch {
                print(error)
            }
        }
    }
}

