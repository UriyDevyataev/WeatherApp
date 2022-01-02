//
//  DayCollectionViewCell.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
