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
    
    @IBOutlet weak var middleContentView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var maxMinLabel: UILabel!
    
    @IBOutlet weak var choiseCityButton: UIButton!
    @IBOutlet weak var currentLocalyButton: UIButton!
    
    var presenter: MWPresenterInput!
    var entity: MWEntity?
    
    var containerHourly = UIView()
    var containerDaily = UIView()
    
    //MARK: - Actions
    
    @IBAction func actionPrint(_ sender: Any) {
        print(view.frame.size)
    }
    
    @IBAction func actionChoiseCity(_ sender: Any) {
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
        configContentView()
        configBar()
    }
    
    func configContentView() {
        middleContentView.corner(withRadius: 10)
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
    
    func fillScrollView() {
        createHourlyView()
        createDailyView()
    }
    
    func createContainer() -> UIView {
        let container = UIView(frame: CGRect.zero)
        container.backgroundColor = .black
        container.corner(withRadius: 10)
        return container
    }
    
    func createHourlyView() {
        containerHourly.removeFromSuperview()
        containerHourly = createContainer()
        contentView.addSubview(containerHourly)
        
        containerHourly.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(100)
        }
        containerHourly.layoutIfNeeded()
            
        let controller = HourlyViewController()
        controller.update(withData: entity?.weather.hourly)
        controller.sizeView = containerHourly.frame.size
        
        addChildViewController(container: containerHourly, controller: controller)
    }
    
    func createDailyView() {
        containerDaily.removeFromSuperview()
        containerDaily = createContainer()
        contentView.addSubview(containerDaily)
        
        let controller = DayViewController()
        controller.update(withData: entity?.weather.daily)
        
        addChildViewController(container: containerDaily, controller: controller)
        
        containerDaily.snp.makeConstraints { make in
            make.top.equalTo(containerHourly.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(controller.mainHeigh)
        }
        containerDaily.layoutIfNeeded()
    }
        
    func addChildViewController(container: UIView, controller: UIViewController) {
        addChild(controller)
        container.addSubview(controller.view)
        controller.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        controller.didMove(toParent: self)
    }
    
    func updateView(with entity: MWEntity) {
        self.entity = entity
        let weather = entity.weather
        
        let temp = "\(weather.current.temp.rounded())\u{00B0}"
        let feelLike = "Ощущается как: \(weather.current.feels_like.rounded())\u{00B0}"
        let maxTemp = "Макс.: \(weather.daily[0].temp.max.rounded())\u{00B0}"
        let minTemp = "мин.: \(weather.daily[0].temp.min.rounded())\u{00B0}"
        let maxMinTemp = "\(maxTemp), \(minTemp)"
        let weatherInfo = weather.current.weather[0].description.capitalized
        
        DispatchQueue.main.async {
            self.fillScrollView()
            self.cityLabel.text = entity.city.name
            self.temperatureLabel.text = temp
            self.feelLikeLabel.text = feelLike
            self.infoLabel.text = weatherInfo
            self.maxMinLabel.text = maxMinTemp
        }
    }
}

//MARK: - Extension MWPresenterOutput

extension MWViewController: MWPresenterOutput{
    func setState(entity: MWEntity) {
        
        updateView(with: entity)
        print("setState")
    }
}
