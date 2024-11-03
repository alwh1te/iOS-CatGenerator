//
//  CatCollectionTableViewCell.swift
//  CatGenerator
//
//  Created by Alexander on 03.11.2024.
//

import UIKit

class CatTableViewCell: UITableViewCell {
    @IBOutlet weak var catImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
