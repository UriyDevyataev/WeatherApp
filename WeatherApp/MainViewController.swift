//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 03.01.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func addChildViewController(container: UIView, controller: UIViewController) {
        
        addChild(controller)
        container.addSubview(controller.view)
        controller.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        controller.didMove(toParent: self)
        
    }
    
    func config() {
        
        let container1 = createContainer()
        let container2 = createContainer()
        let container3 = createContainer()
        let container4 = createContainer()
        
        container2.backgroundColor = .red
        
        
        contentView.addSubview(container1)
        contentView.addSubview(container2)
        
        container1.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(300)
        }
        container1.layoutIfNeeded()
        
//        addChildViewController(container: container1, controller: HourlyViewController())
        
        container2.snp.makeConstraints { make in
            make.top.equalTo(container1.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(300)
        }
        container2.layoutIfNeeded()
        
        let controller = DayViewController()
//        addChildViewController(container: container2, controller: controller)
        
//        print(controller.mainHeigh)
//        
//        
//        container2.snp.updateConstraints{ make in
//            make.height.equalTo(controller.mainHeigh)
//        }
//        container2.layoutIfNeeded()

        

        
        
        
        
    }
    
    func createContainer() -> UIView {
        let container = UIView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: view.frame.width - 10,
                                             height: 200))
        container.center = view.center
        container.backgroundColor = .cyan
        
        return container
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
