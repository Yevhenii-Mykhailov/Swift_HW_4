//
//  TopRatedTVCell.swift
//  Homework_4
//
//  Created by Yevhenii M on 28.10.2022.
//

import UIKit

class TopRatedTVCell: UITableViewCell {
    @IBOutlet weak var originalTitleLable: UILabel!
    @IBOutlet weak var popularityLable: UILabel!
    @IBOutlet weak var releaseDateLable: UILabel!
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var originalTitle = ""
    var popularity = ""
    var releaseDate = ""
    var filmOverviewText = ""
    var posterPathUrl = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        originalTitleLable.text = originalTitle
        popularityLable.text = popularity
        releaseDateLable.text = releaseDate
        overviewText.text = filmOverviewText
        posterImageView.load(stringUrl: posterPathUrl)
    }
}
