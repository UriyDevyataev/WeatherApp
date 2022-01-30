//
//  AllWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

import UIKit

class AllWeatherCollectionViewCell: UICollectionViewCell {

    static let identifier = "AllWeatherCollectionViewCell"
    
//    var containerView: UIView = {
//        let view = UIView()
////        view.layer.cornerRadius = 25
//        return view
//    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
//    override func prepareForReuse() {
//        <#code#>
//    }

    private func config() {
        configСontainerView()
    }
    private func configСontainerView() {
        
//        contentView.addSubview(containerView)
//        containerView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.bottom.equalToSuperview()
//        }
//        containerView.backgroundColor = .clear
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AllWeatherCollectionViewCell",
                     bundle: nil)
    }

}
