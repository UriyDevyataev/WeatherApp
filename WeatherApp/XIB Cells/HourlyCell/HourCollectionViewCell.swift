//
//  HourCollectionViewCell.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 03.01.2022.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
