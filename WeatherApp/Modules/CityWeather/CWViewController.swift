//
//  CWViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

import UIKit
import SpriteKit

class CWViewController: UIViewController {
    
    @IBOutlet weak var skView: SKView!
    
    var presenter: CWPresenterInput!
    var scene: SKScene?
    
    @IBOutlet weak var scrollView: UIScrollView!
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
        
//        prepareView()
        configUI()
        presenter.viewIsReady(index: index)
    }
    
    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        print(sender.location(in: self.view))
    }
    
    deinit {
        print("deinit CWViewController")
    }
    
    private func prepareView() {
        let scene = SKScene(size: view.frame.size)
        skView.presentScene(scene)
        self.scene = scene
    }
    
    private func configBackgroud(_ backGround: Background?) {
        guard let backGround = backGround else {return}
        scene?.removeAllChildren()
        scene?.backgroundColor = UIColor.init(backGround.timesOfDay)
        let nodes = backGround.nodes
        nodes.forEach { nodeEntity in
            guard let node = SKSpriteNode(fileNamed: nodeEntity.name) else { return }
            node.position = nodeEntity.position
            self.scene?.addChild(node)
        }
    }
    
    func configUI() {
        topContentView.isHidden = true
        view.backgroundColor = .clear
        buttonContentView.isHidden = true
        if modalPresentationStyle == .formSheet {
            buttonContentView.isHidden = false
//            prepareView()
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
            controller.data = entity?.weather
            controller.sizeView = container.frame.size
            controllerHourly = controller
            addChildViewController(container: container, controller: controller)
        } else {
            let data = entity?.weather
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
        container.backgroundColor = .clear
        container.clipsToBounds = true
        container.corner(withRadius: 15)

        let blurEffect = UIBlurEffect(style: .regular)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.alpha = 1
        container.addSubview(blurredEffectView)
        
        blurredEffectView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
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
        let maxTemp = String(weather.daily[0].temp.max.rounded())
        let minTemp = String(weather.daily[0].temp.min.rounded())
        let maxMinTemp = R.string.localizable.maxMinLabel(maxTemp, minTemp)
        let weatherInfo = weather.current.weather[0].description.capitalized
        
        
        
        DispatchQueue.main.async {
            self.topContentView.isHidden = false
            self.fillScrollView()
            self.cityLabel.text = entity.city.name
            self.temperatureLabel.text = temp
            self.infoLabel.text = weatherInfo
            self.maxMinLabel.text = maxMinTemp
            
            if self.modalPresentationStyle == .formSheet {
//                self.configBackgroud(entity.background)
            }
            
        }
    }
}

extension CWViewController: CWPresenterOutput {
    func setState(entity: CWEntity) {
        print("CW_setState")
        updateView(with: entity)
    }
}

extension CWViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(scrollView.panGestureRecognizer.location(in: self.view))
    }
    
}
