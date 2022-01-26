//
//  NewViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 24.01.2022.
//

import UIKit

class NewViewController: UIViewController {
    @IBOutlet weak var labelInternet: UILabel!
    
    let serviceConnected: Connect = ConnectImp()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if serviceConnected.checkConnection(){
            print("Internet Connection Available!")
            labelInternet.text = "Internet Connection Available!"
        }else{
            print("Internet Connection not Available!")
            labelInternet.text = "Internet Connection not Available!"
        }
        
        // Do any additional setup after loading the view.
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
