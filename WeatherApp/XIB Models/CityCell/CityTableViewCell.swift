//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 06.01.2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        customContentView.backgroundColor = .clear
        cityLabel.textColor = .white
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
