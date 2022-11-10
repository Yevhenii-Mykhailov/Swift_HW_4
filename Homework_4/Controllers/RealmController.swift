//
//  RealmController.swift
//  Homework_4
//
//  Created by Yevhenii M on 10.11.2022.
//

import Foundation
import RealmSwift

class RealmController {
    private let realm = try! Realm()
    
    func getAllFromRealm() -> [TopRatedModel] {
        let realmObject = realm.objects(TopRatedModel.self)
        var result: [TopRatedModel] = []
        for (_ ,item) in realmObject.enumerated() {
            result.append(item)
        }
        
        return result
    }
    
    func getFilmsByPageFromRealm(_ pageNumber: Int) -> TopRatedModel {
        let realmObject = realm.objects(TopRatedModel.self)
        let ralmQuery = realmObject.where {
            ($0.page == pageNumber)
        }
        guard let result = ralmQuery.first else { return TopRatedModel() }
        
        return result
    }
    
    func addTopRatedFilmsToRealm(_ filmResults: TopRatedModel) {
        let topRatedFilms = filmResults
        
        try! realm.write({
            realm.add(topRatedFilms)
        })
    }
}
