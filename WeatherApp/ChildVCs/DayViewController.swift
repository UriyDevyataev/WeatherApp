//
//  DayViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 03.01.2022.
//

import Foundation
import UIKit
import SnapKit

class DayViewController: UIViewController {
    
    private var collectionView : UICollectionView?
    
    var data = [DailyWeather]()
    let cellHeigh: Double = 50
    var mainHeigh = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config(){
        view.backgroundColor = .clear
        configCollectionView()
    }
    
    func update(withData: [DailyWeather]?) {
        guard let data = withData else {return}
        self.data = data
        collectionView?.reloadData()
    }
    
    private func configCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
    
        collectionView.register(
            UINib(nibName: "DayCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "DayCollectionViewCellIdent")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        collectionView.layoutIfNeeded()
    }
    
    private func fill(cell: DayCollectionViewCell, withContent: DailyWeather) -> UICollectionViewCell {
        let minTemp = "\(withContent.temp.min.rounded())\u{00B0}"
        let maxTemp = "\(withContent.temp.max.rounded())\u{00B0}"
        let day = withContent.dt.strDayFromUTC()
        
        cell.dayLabel.text = day
        cell.minTempLabel.text = minTemp
        cell.maxTempLabel.text = maxTemp
        cell.imageView.image = UIImage()
    
        return cell
    }
}

extension DayViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = data.count
        mainHeigh = count * Int(cellHeigh)
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let dailyCell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: "DayCollectionViewCellIdent",
                    for: indexPath) as? DayCollectionViewCell
        else {return UICollectionViewCell()}
        
        let cell = fill(cell: dailyCell, withContent: data[indexPath.row])
        return cell
    }
}

extension DayViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        let height = cellHeigh
        return CGSize(width: width, height: height)
    }
}
