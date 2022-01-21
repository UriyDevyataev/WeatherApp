//
//  ViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 18.01.2022.
//

import UIKit

class ViewController: UIPageViewController {

    var vcArr = [CWViewController]()
    
    let weatherListService: WeatherListService = WeatherListServiceImp.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationButton()
        self.view.backgroundColor = .orange
        self.delegate = self
        self.dataSource = self
        let _ = weatherListService.getCountList()
        let entArr = weatherListService.getList()
        
    
        
        entArr.forEach{ entity in
            let vc = CWAssembly.configurateModule(output: nil)!
//            guard let vc = UIStoryboard(name: "CityWeathe", bundle: nil).instantiateViewController(withIdentifier: "CityWeatherVC") as? CWViewController else {return}
            vc.entity = entity
            vc.view.backgroundColor = .clear
            vcArr.append(vc)
        }
        
        print(vcArr.count)
        
//        let vc = vcArr[0] as! UIViewController
        setViewControllers([vcArr[1]], direction: .forward, animated: true, completion: nil)
        
        
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
