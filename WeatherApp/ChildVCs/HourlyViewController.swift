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
    
        cv.register(
            UINib(nibName: "DayCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "DayCollectionViewCellIdent")
        
        view.addSubview(cv)
        cv.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        cv.layoutIfNeeded()
        collectionView = cv
    }
}

extension HourlyViewController: UICollectionViewDelegate {
    
}

extension HourlyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: "DayCollectionViewCellIdent",
                    for: indexPath) as? DayCollectionViewCell
        else {return UICollectionViewCell()}
        cell.customContentView.backgroundColor = .green

        return cell
    }
}

extension HourlyViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: collectionView.frame.size.width,
                          height: 50)
        return size
    }
}
