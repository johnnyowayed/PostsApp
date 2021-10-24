//
//  TitleSubtitleTableViewCell.swift
//  PostsApp
//
//  Created by Johnny on 21/10/2021.
//

import UIKit

class TitleSubtitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title_Label:UILabel!
    @IBOutlet weak var subTitle_Label:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title_Label.font = .systemFont(ofSize: 16)
        self.title_Label.numberOfLines = 2
        self.subTitle_Label.font = .systemFont(ofSize: 12)
        self.subTitle_Label.textColor = .gray
        self.subTitle_Label.numberOfLines = 2
    }
}
