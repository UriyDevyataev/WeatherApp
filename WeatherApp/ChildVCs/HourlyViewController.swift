//
//  HourlyViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation
import UIKit
import SnapKit

class HourlyViewController: UIViewController {
    
    private var collectionView : UICollectionView?
    var data = [HourlyWeather]()
    var sizeView = CGSize.zero
        
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config(){
        view.backgroundColor = .clear
        configCollectionView()
    }
    
    func update(withData: [HourlyWeather]?) {
        guard let data = withData else {return}
        self.data = data
        collectionView?.reloadData()
    }

    private func configCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(
            UINib(nibName: "HourCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "HourCollectionViewCellIdent")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        collectionView.layoutIfNeeded()
    }

    private func fill(cell: HourCollectionViewCell, withContent: HourlyWeather) -> UICollectionViewCell {
        cell.hourLabel.text = withContent.dt.strHourFromUTC()
        cell.tempLabel.text = "\(Int(withContent.temp.rounded()))\u{00B0}"
        cell.imageView.image = UIImage()
        return cell
    }
}

extension HourlyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count > 24 ? 24 : data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let hourlyCell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: "HourCollectionViewCellIdent",
                    for: indexPath) as? HourCollectionViewCell
        else {return UICollectionViewCell()}
        
        let cell = fill(cell: hourlyCell, withContent: data[indexPath.row])

        return cell
    }
}

extension HourlyViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = sizeView.width / 6
        let height = sizeView.height
        return CGSize(width: width, height: height)
    }
}
