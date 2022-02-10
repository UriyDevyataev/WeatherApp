//
//  ViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 18.01.2022.
//

import UIKit
import CoreLocation

class ViewController: UIPageViewController {

    var vcArr = [CWViewController]()
    
    let weatherListService: WeatherListService = WeatherListServiceImp.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Affeltrangen
//        47.52581
//        9.03307
//        Fgura
//        35.87028
//        14.51333
        
//        Купертино
//        37.33233141
//        -122.0312186
        
//        var location = CLLocation(latitude: 35.87028,
//                               longitude: 14.51333)
//
//        getPlaceFrom(location: location) { place, error in
////            guard let place = place?[0], error == nil else {return}
//            print(place)
//        }
//
//        location = CLLocation(latitude: 37.33233141,
//                               longitude: -122.0312186)
//
//        getPlaceFrom(location: location) { place, error in
////            guard let place = place?[0], error == nil else {return}
//            print(place)
//        }
//        configNavigationButton()
//        self.view.backgroundColor = .orange
//        self.delegate = self
//        self.dataSource = self
//        let _ = weatherListService.getCountList()
//        let entArr = weatherListService.getList()
//
//
//
//        entArr.forEach{ entity in
//            let vc = CWAssembly.configurateModule(output: nil)!
////            guard let vc = UIStoryboard(name: "CityWeathe", bundle: nil).instantiateViewController(withIdentifier: "CityWeatherVC") as? CWViewController else {return}
//            vc.entity = entity
//            vc.view.backgroundColor = .clear
//            vcArr.append(vc)
//        }
//
//        print(vcArr.count)
//
////        let vc = vcArr[0] as! UIViewController
//        setViewControllers([vcArr[1]], direction: .forward, animated: true, completion: nil)
        
        
    }
    
    func configNavigationButton(){
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.left.fill"), style: .plain, target: self, action: #selector(actionBack))
        
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.left.fill"), style: .plain, target: self, action: nil)
        
//        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 10
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.backgroundColor = .yellow

        
        let flexButton = UIBarButtonItem.flexibleSpace()
        
        let buttonArray = [backButton, flexButton, forwardButton]
        toolbarItems = buttonArray
    
        navigationController?.toolbar.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            
//            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(30)
            
//            make.bottom.equalToSuperview().offset(-40)
//            make.height.equalTo(height)
        }
        pageControl.layoutIfNeeded()
        
        
    }
    
    @objc func actionBack(){
        print("actionBack")
    }
    
    private func getPlaceFrom(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { place, error in
            completion(place, error)
        }
    }

}

extension ViewController: UIPageViewControllerDelegate {
    
}

extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let curIndex = vcArr.firstIndex(of: viewController as! CWViewController)
        
        if curIndex == 0 {
            return nil
        } else {
            return vcArr[curIndex! - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let curIndex = vcArr.firstIndex(of: viewController as! CWViewController)
        
        if curIndex == vcArr.count - 1 {
            return nil
        } else {
            return vcArr[curIndex! + 1]
        }
    }
}

//    func createHourlyView() {
//
//        if controllerHourly == nil {
//
//            let container = createContainer()
//            contentView.addSubview(container)
//            container.snp.makeConstraints { make in
//                make.top.equalToSuperview()
//                make.leading.equalToSuperview().offset(0)
//                make.trailing.equalToSuperview().offset(0)
//                make.height.equalTo(100)
//            }
//            container.layoutIfNeeded()
//            containerHourly = container
//
//            let controller = HourlyViewController()
//            controller.data = entity?.weather
//            controller.sizeView = container.frame.size
//            controllerHourly = controller
//            addChildViewController(container: container, controller: controller)
//        } else {
//            let data = entity?.weather
//            controllerHourly?.update(withData: data)
//        }
//    }

//    func createDailyView() {
//
//        if controllerDaily == nil {
//
//            let controller = DayViewController()
//            let data = entity?.weather?.daily
//            controller.data = data
//            controllerDaily = controller
//
//            let cellHeight = data?.count ?? 7
//            let height = Int(controller.cellHeigh) * cellHeight
//
//            let container = createContainer()
//            contentView.addSubview(container)
//            container.snp.makeConstraints { make in
//                make.top.equalTo(containerHourly.snp.bottom).offset(15)
//                make.leading.equalToSuperview().offset(0)
//                make.trailing.equalToSuperview().offset(0)
//                make.bottom.equalToSuperview().offset(-40)
//                make.height.equalTo(height)
//            }
//            container.layoutIfNeeded()
//            containerDaily = container
//
//            addChildViewController(container: containerDaily, controller: controller)
//        } else {
//            let data = entity?.weather?.daily
//            controllerDaily?.update(withData: data)
//        }
//    }
