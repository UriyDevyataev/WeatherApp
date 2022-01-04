//
//  MWViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation
import UIKit
import SnapKit

class MWViewController: UIViewController {
    
    @IBAction func actionPrint(_ sender: Any) {
        print(view.frame.size)
        print(collectionView.frame.size)
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var maxMinLabel: UILabel!
    
    @IBOutlet weak var choiseCityButton: UIButton!
    @IBOutlet weak var currentLocalyButton: UIButton!
    
    var presenter: MWPresenterInput!
        
    @IBAction func actionChoiseCity(_ sender: Any) {
    }
    
    @IBAction func actionCurrentLocaly(_ sender: Any) {
        
        presenter.actionGetLocalWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        presenter.viewIsReady()
    }
    
    func config(){
        configCollectionView()
        configBar()
        
    }
    
    func updateView(with entity: MWEntity){
        
        DispatchQueue.main.async {
            self.cityLabel.text = entity.city.name
            self.temperatureLabel.text = String(entity.weather.current.temp)
            self.infoLabel.text = String(entity.weather.current.feels_like)
            self.infoLabel.text = String(entity.weather.current.feels_like)
        }
    }
    
    func configCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .cyan   
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func configBar(){
        
        currentLocalyButton.setTitle("", for: .normal)
        currentLocalyButton.setImage(UIImage(systemName: "location"), for: .normal)
        currentLocalyButton.tintColor = .black
        
        choiseCityButton.setTitle("", for: .normal)
        choiseCityButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        choiseCityButton.tintColor = .black
    }
    
    func addChildViewController(container: UIView, controller: UIViewController) {
        
        addChild(controller)
        container.addSubview(controller.view)
        controller.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        controller.didMove(toParent: self)
        
    }
    
}

extension MWViewController: MWPresenterOutput{
    func setState(entity: MWEntity) {
        updateView(with: entity)
        print("setState")
    }
}

extension MWViewController: UICollectionViewDelegate {
    
}

extension MWViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        
        switch indexPath.row {
        case 0:
            addChildViewController(container: cell.contentView, controller: HourlyViewController())
//        case 1:
//            addChildViewController(container: cell.contentView, controller: DayViewController())
        default: break
        }
        
        cell.backgroundColor = .brown
        
        return cell
    }
}

extension MWViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height
                
        var size = CGSize.zero
        switch indexPath.row {
        case 0:
            size = CGSize(width: width, height: height/5)
        case 1:
            size = CGSize(width: width, height: 10 * 50 )
        default: break
        }
        
        return size
    }
}
