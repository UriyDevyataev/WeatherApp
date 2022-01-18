//
//  BigWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

import UIKit
import SnapKit

class BigWeatherCollectionViewCell: UICollectionViewCell {

    static let identifier = "BigWeatherCollectionViewCell"
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 25
        return view
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }

    private func config() {
        configСontainerView()
    }
    private func configСontainerView() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        containerView.backgroundColor = .clear
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "BigWeatherCollectionViewCell",
                     bundle: nil)
    }
}
