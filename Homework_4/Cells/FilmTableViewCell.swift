//
//  FilmTableViewCell.swift
//  Homework_4
//
//  Created by Yevhenii M on 28.10.2022.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    @IBOutlet weak var originalTitleLable: UILabel!
    @IBOutlet weak var popularityLable: UILabel!
    @IBOutlet weak var releaseDateLable: UILabel!
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var originalTitle = ""
    var popularity = ""
    var releaseDate = ""
    var filmOverviewText = ""
    var arrayOfTopRatedFilms: [TopRatedRealmResult] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.activityIndicator.hidesWhenStopped = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        originalTitleLable.text = originalTitle
        popularityLable.text = popularity
        releaseDateLable.text = releaseDate
        overviewText.text = filmOverviewText
    }
}
