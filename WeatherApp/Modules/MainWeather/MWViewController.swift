//
//  MWViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation

class MWViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomContentView: UIView!
    @IBOutlet weak var choiseCityButton: UIButton!
    @IBOutlet weak var currentLocalyButton: UIButton!
    
    var presenter: MWPresenterInput!
    var entity: MWEntity?
    
    //MARK: - Actions
        
    @IBAction func actionChoiseCity(_ sender: Any) {
        presenter.actionShowChoiseCity()
    }
    
    @IBAction func actionCurrentLocaly(_ sender: Any) {
        presenter.actionGetLocalWeather()
    }

    //MARK: - App Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        presenter.viewIsReady()
    }
    
    //MARK: - Funcs configuration
    
    func config(){
        configLocation()
        configBar()
        configCollectionView()
    }
    
    func configLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .blue
        collectionView.isPagingEnabled = true
        
        collectionView.register(AllWeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: AllWeatherCollectionViewCell.identifier)
    }
    
    func configBar(){
        currentLocalyButton.setTitle("", for: .normal)
        currentLocalyButton.setImage(UIImage(systemName: "location"), for: .normal)
        currentLocalyButton.tintColor = .black
    
        choiseCityButton.setTitle("", for: .normal)
        choiseCityButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        choiseCityButton.tintColor = .black
    }
    
    //MARK: - Funcs Other
    
    func addChildViewController(container: UIView, controller: UIViewController) {
        addChild(controller)
        
        container.subviews.forEach{view in
            view.removeFromSuperview()
        }
        
        container.addSubview(controller.view)
        controller.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        controller.didMove(toParent: self)
    }
    
    func updateView(with entity: MWEntity) {
        self.entity = entity
        self.collectionView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.collectionView.scrollToItem(
                at: IndexPath(item: entity.choisedIndex, section: 0),
                at: .left,
                animated: false)
        }
    }
}

extension MWViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entity?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AllWeatherCollectionViewCell.identifier,
            for: indexPath) as? AllWeatherCollectionViewCell
        else {return UICollectionViewCell()}
        
        cell.backgroundColor = .green
        guard let controller = CWAssembly.configurateModule(output: nil) else {return cell}
        
        cell.containerView.backgroundColor = .red
        controller.index = indexPath.row
    
        addChildViewController(container: cell.containerView, controller: controller)
        return cell
    }
}

extension MWViewController: UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension MWViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        presenter.viewIsReady()
    }
}

//MARK: - Extension MWPresenterOutput

extension MWViewController: MWPresenterOutput{
    func setState(entity: MWEntity) {
        print("MW_setState")
        updateView(with: entity)
    }
}
