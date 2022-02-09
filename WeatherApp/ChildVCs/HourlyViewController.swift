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
    var data: WeatherResponse?
    var sizeView = CGSize.zero
        
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    deinit {
//        print("deinit HourlyViewController")
    }
    
    private func config(){
        view.backgroundColor = .clear
        configCollectionView()
    }
    
    func update(withData: WeatherResponse?) {
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
        self.collectionView = collectionView
    }

    private func fill(cell: HourCollectionViewCell, withContent: WeatherResponse, index: Int) -> UICollectionViewCell {
        let offset = withContent.timezone_offset
        let hourData = withContent.hourly[index]

        let hour = hourData.dt.strHourFromUTC(offset: offset)
        let temp = "\(Int(hourData.temp.rounded()))\u{00B0}"
        
        var nameImage = hourData.weather[0].icon
        nameImage = "\(nameImage.dropLast())d"
        let image = UIImage(named: nameImage)
        
        cell.hourLabel.text = hour
        cell.tempLabel.text = temp
        cell.imageView.image = image
        return cell
    }
}

extension HourlyViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = data?.hourly.count else {return 0}
        return count > 24 ? 24 : count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let hourlyCell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: "HourCollectionViewCellIdent",
                    for: indexPath) as? HourCollectionViewCell
        else {return UICollectionViewCell()}
        
        guard let data = data else {return hourlyCell}
        
        let cell = fill(cell: hourlyCell, withContent: data, index: indexPath.row)

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
