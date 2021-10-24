//
//  InputTextFeildTableViewCell.swift
//  PostsApp
//
//  Created by Johnny on 21/10/2021.
//

import UIKit

class InputTextFeildTableViewCell: UITableViewCell {
    
    @IBOutlet weak var input_Textfeild: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
