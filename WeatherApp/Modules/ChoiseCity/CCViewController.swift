//
//  CCViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import UIKit

class CCViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: CCPresenterInput!
    
    var entity = CCEntity(isCityChoising: false,
                          cityDict: [String: CityModel](),
                          weatherList: [MWEntity]())
    
    var cityList = [String]()
    var weatherList = [MWEntity]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        configSearcBar()
        configTableView()
        presenter.viewIsReady()
    }
    
    func configSearcBar() {
        searchBar.delegate = self
        
        let textField = searchBar.searchTextField
        textField.textColor = .white
        textField.backgroundColor = .black
        
        guard let glassIconView = textField.leftView
                as? UIImageView else {return}
        glassIconView.tintColor = .white
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Удалить"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
    }
    
    func configTableView(){
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(
            UINib(nibName: "CityTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CityTableViewCellIdentifire")
        
        tableView.register(
            UINib(nibName: "WeatherTableViewCell", bundle: nil),
            forCellReuseIdentifier: "WeatherTableViewCellIdentifire")
    }
    
    func updateControls(entity: CCEntity) {
        self.entity = entity
        switch entity.isCityChoising {
        case true:
            cityList.removeAll()
            
            entity.cityDict.forEach { (key: String, value: CityModel) in
                cityList.append(key)
            }
        case false:
            weatherList = entity.weatherList
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func fill(cell: WeatherTableViewCell, withContent: MWEntity) -> UITableViewCell {
        
        guard let weather = withContent.weather else {return UITableViewCell()}
        
        let cityName = withContent.city.name
        let temp = "\(weather.current.temp.rounded())\u{00B0}"
        
        
        let maxTemp = "Макс.: \(weather.daily[0].temp.max.rounded())\u{00B0}"
        let minTemp = "мин.: \(weather.daily[0].temp.min.rounded())\u{00B0}"
    
        let maxMinTemp = "\(maxTemp), \(minTemp)"
        
        var info = ""
        if let alerts = weather.alerts {
            alerts.forEach { alert in
                info += alert.event
            }
        }
        
        cell.cityLabel.text = cityName
        cell.timeLabel.text = "time"
        cell.tempLabel.text = temp
        cell.infoLabel.text = info
        cell.maxMinTempLabel.text = maxMinTemp
        
        return cell
    }
}

extension CCViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  entity.isCityChoising ? cityList.count : weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch entity.isCityChoising {
        case true:
            guard let cityCell = tableView.dequeueReusableCell(
                withIdentifier: "CityTableViewCellIdentifire",
                for: indexPath) as? CityTableViewCell else {
                    return UITableViewCell()
                }
            
            let nameCity = cityList[indexPath.row]
            cityCell.cityLabel.text = nameCity
            cell = cityCell
            
        case false:
            
            guard let weatherCell = tableView.dequeueReusableCell(
                withIdentifier: "WeatherTableViewCellIdentifire",
                for: indexPath) as? WeatherTableViewCell else {
                    return UITableViewCell()
                }
            
            let content = weatherList[indexPath.row]
            cell = fill(cell: weatherCell, withContent: content)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch entity.isCityChoising {
        case true:
            guard let cell = tableView.cellForRow(
                at: indexPath) as? CityTableViewCell else {return}
            
            guard let city = entity.cityDict[cell.cityLabel.text ?? ""] else {return}
            presenter.choisedCity(city: city)
        case false:
            let entity = weatherList[indexPath.row]
            print(entity.city.name)
            //show mw view controller with entity
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return entity.isCityChoising ? 40 : 100
    }
}

extension CCViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        entity.isCityChoising = searchText.count != 0
        presenter.changedCity(text: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        entity.isCityChoising = false
        
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CCViewController: CCPresenterOutput {
    func setState(entity: CCEntity) {
        updateControls(entity: entity)
    }
}
