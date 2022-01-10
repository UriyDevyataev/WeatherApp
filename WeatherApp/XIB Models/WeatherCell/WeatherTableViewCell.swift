//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 08.01.2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var topContentView: UIView!
    @IBOutlet weak var bottomContentView: UIView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customContentView.corner(withRadius: 10)
        customContentView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
