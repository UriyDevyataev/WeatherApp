//
//  Tile.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 28.01.2022.
//

import UIKit

struct Tile {
    var name: String
    var value: String
    var info: String
}
class TileView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
        
    override func layoutSubviews() {
        super.layoutSubviews()
        configFont()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLabel()
    }
    
    private func configLabel() {
        nameLabel.textColor = .white
        valueLabel.textColor = .white
        infoLabel.textColor = .white
    }
    
    private func configFont() {
        nameLabel.font = UIFont.systemFont(ofSize: nameLabel.frame.height)
        valueLabel.font = UIFont.systemFont(ofSize: valueLabel.frame.height * 0.7)
        infoLabel.adjustsFontSizeToFitWidth = true
    }
    
    func fillInfo(data: Tile) {
        nameLabel.text = data.name
        valueLabel.text = data.value
        infoLabel.text = data.info
    }
}
