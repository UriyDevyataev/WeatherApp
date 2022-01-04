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
    
    var collectionView : UICollectionView?
    var data = [DayWeather]()
    
    let cellHeigh = 50
    var mainHeigh = 0
        
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
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        cv.backgroundColor = .blue
        
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
    
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

extension DayViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
        mainHeigh = 10 * cellHeigh
        return 10
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

extension DayViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: collectionView.frame.size.width,
                          height: 50)
        return size
    }
}
