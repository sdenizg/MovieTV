//
//  TVTableViewCell.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 3.11.2022.
//

import UIKit

class TVTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tvImg: UIImageView!
    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvViewNum: UILabel!
    @IBOutlet weak var tvDate: UILabel!
    @IBOutlet weak var tvRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
