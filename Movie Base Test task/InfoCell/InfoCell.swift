//
//  InfoCell.swift
//  Movie Base Test task
//
//  Created by Bohdan Kindy on 08.05.2021.
//

import UIKit

class InfoCell: UICollectionViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    //MARK: - CollectionViewCell LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        clipsToBounds = false
    }
}
