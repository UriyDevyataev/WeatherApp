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
    
    var collectionView : UICollectionView?
    var data = [DayWeather]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config(){
        view.backgroundColor = .red
        configCollectionView()
    }

    func configCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    
        cv.backgroundColor = .blue
        
        cv.delegate = self
        cv.dataSource = self
        
        cv.showsHorizontalScrollIndicator = false
        
        cv.register(
            UINib(nibName: "HourCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "HourCollectionViewCellIdent")
        
        view.addSubview(cv)
        cv.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        cv.layoutIfNeeded()
        collectionView = cv
    }
}

extension HourlyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: "HourCollectionViewCellIdent",
                    for: indexPath) as? HourCollectionViewCell
        else {return UICollectionViewCell()}
        cell.customContentView.backgroundColor = .green

        return cell
    }
}

extension HourlyViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height
        
        let size = CGSize(width: width / 6,
                          height: height)
        return size
    }
    

}
