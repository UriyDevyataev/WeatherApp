//
//  CWViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

import UIKit

class CWViewController: UIViewController {
    
    var presenter: CWPresenterInput!
    
    var index: Int?
    var entity: CWEntity?
    
    var containerHourly = UIView()
    var containerDaily = UIView()
    
    var controllerHourly: HourlyViewController?
    var controllerDaily: DayViewController?
    
    @IBOutlet weak var topContentView: UIView!
    @IBOutlet weak var buttonContentView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var maxMinLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBAction func actionCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionAdd(_ sender: UIButton) {
        presenter.actionAdd()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        presenter.viewIsReady(index: index)
    }
    
    deinit {
        print("deinit CWViewController")
    }
    
    func configUI() {
        topContentView.isHidden = true
        view.backgroundColor = .clear
        buttonContentView.isHidden = true
        if modalPresentationStyle == .formSheet {
            buttonContentView.isHidden = false
            view.backgroundColor = .gray
        }
        fillScrollView()
    }
    
    func fillScrollView() {
        createHourlyView()
        createDailyView()
    }
    
    func createHourlyView() {
        if controllerHourly == nil {
            
            let container = createContainer()
            contentView.addSubview(container)
            container.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview().offset(0)
                make.trailing.equalToSuperview().offset(0)
                make.height.equalTo(100)
            }
            container.layoutIfNeeded()
            containerHourly = container
            
            let controller = HourlyViewController()
            controller.data = entity?.weather?.hourly
            controller.sizeView = container.frame.size
            controllerHourly = controller
            addChildViewController(container: container, controller: controller)
        } else {
            let data = entity?.weather?.hourly
            controllerHourly?.update(withData: data)
        }
    }

    func createDailyView() {
        
        if controllerDaily == nil {
            
            let controller = DayViewController()
            let data = entity?.weather?.daily
            controller.data = data
            controllerDaily = controller
            
            let cellHeight = data?.count ?? 7
            let height = Int(controller.cellHeigh) * cellHeight
                        
            let container = createContainer()
            contentView.addSubview(container)
            container.snp.makeConstraints { make in
                make.top.equalTo(containerHourly.snp.bottom).offset(15)
                make.leading.equalToSuperview().offset(0)
                make.trailing.equalToSuperview().offset(0)
                make.bottom.equalToSuperview().offset(-40)
                make.height.equalTo(height)
            }
            container.layoutIfNeeded()
            containerDaily = container
            
            addChildViewController(container: containerDaily, controller: controller)
        } else {
            let data = entity?.weather?.daily
            controllerDaily?.update(withData: data)
        }  
    }
    
    func createContainer() -> UIView {
        let container = UIView(frame: CGRect.zero)
        container.backgroundColor = .black.withAlphaComponent(0.5)
        container.corner(withRadius: 15)
        return container
    }
    
    func addChildViewController(container: UIView, controller: UIViewController) {
        addChild(controller)
        container.addSubview(controller.view)
        controller.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        controller.didMove(toParent: self)
    }
    
    func updateView(with entity: CWEntity) {
        self.entity = entity        
        guard let weather = entity.weather else {return}
        
        let temp = "\(weather.current.temp.rounded())\u{00B0}"
        let maxTemp = "Макс.: \(weather.daily[0].temp.max.rounded())\u{00B0}"
        let minTemp = "мин.: \(weather.daily[0].temp.min.rounded())\u{00B0}"
        let maxMinTemp = "\(maxTemp), \(minTemp)"
        let weatherInfo = weather.current.weather[0].description.capitalized
        
        DispatchQueue.main.async {
            self.topContentView.isHidden = false
            self.fillScrollView()
            self.cityLabel.text = entity.city.name
            self.temperatureLabel.text = temp
            self.infoLabel.text = weatherInfo
            self.maxMinLabel.text = maxMinTemp
        }
    }
}

extension CWViewController: CWPresenterOutput {
    func setState(entity: CWEntity) {
        print("CW_setState")
        updateView(with: entity)
    }
}
