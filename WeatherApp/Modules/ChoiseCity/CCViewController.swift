//
//  CCViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import UIKit

class CCViewController: UIViewController {
    
    var presenter: CCPresenterInput!
    var entity: CCEntity?
    
    var cityList = [String]()
    var weatherList = [CWEntity]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    deinit {
        print("deinit CCViewController")
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
    
    func updateView(entity: CCEntity) {
        
        self.entity = entity
        
        switch entity.isCityChoising {
        case true:
            cityList.removeAll()
            entity.cityDict?.forEach { (key: String, value: CityModel) in
                cityList.append(key)
            }
        case false:
            weatherList = entity.weatherList ?? [CWEntity]()
            
            DispatchQueue.main.async {
                self.searchBar.text = ""
                self.searchBar.showsCancelButton = false
                self.searchBar.resignFirstResponder()
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func fill(cell: WeatherTableViewCell, withContent: CWEntity) -> UITableViewCell {

        
        guard let weather = withContent.weather else {return UITableViewCell()}
                
        let cityName = withContent.city.name
//        print(weather.current.dt.strTimeFromUTC())
//        print(weather.timezone_offset.strTimeFromUTC())
//        let time = (weather.current.dt + weather.timezone_offset).strTimeFromUTC()
        let time = weather.current.dt.strTimeFromUTC()
        let temp = "\(weather.current.temp.rounded())\u{00B0}"

        let maxTemp = "Макс.: \(weather.daily[0].temp.max.rounded())\u{00B0}"
        let minTemp = "мин.: \(weather.daily[0].temp.min.rounded())\u{00B0}"

        let maxMinTemp = "\(maxTemp), \(minTemp)"

        var info = ""
        if let alerts = weather.alerts {
            info = alerts.count > 1 ? alerts[1].event : alerts[0].event
        } else {
            info = weather.current.weather[0].description
        }

        cell.cityLabel.text = cityName
        cell.timeLabel.text = time
        cell.tempLabel.text = temp
        cell.infoLabel.text = info
        cell.maxMinTempLabel.text = maxMinTemp

        return cell
    }
}

extension CCViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entity = self.entity else {return 0}
        return  entity.isCityChoising ? cityList.count : weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        guard let entity = self.entity else {return cell}
        
        switch entity.isCityChoising {
        case true:
            guard let cityCell = tableView.dequeueReusableCell(
                withIdentifier: "CityTableViewCellIdentifire",
                for: indexPath) as? CityTableViewCell else {
                    return cell
                }
            
            let nameCity = cityList[indexPath.row]
            cityCell.cityLabel.text = nameCity
            cell = cityCell
            
        case false:
            
            guard let weatherCell = tableView.dequeueReusableCell(
                withIdentifier: "WeatherTableViewCellIdentifire",
                for: indexPath) as? WeatherTableViewCell else {
                    return cell
                }
            
            let content = weatherList[indexPath.row]
            cell = fill(cell: weatherCell, withContent: content)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let entity = self.entity else {return}
        switch entity.isCityChoising {
        case true:
            guard let cell = tableView.cellForRow(
                at: indexPath) as? CityTableViewCell else {return}
            guard let city = entity.cityDict?[cell.cityLabel.text ?? ""]
            else {return}
            presenter.choisedCity(city: city)
        case false:
            presenter.choisedCity(index: indexPath.row)
            self.dismiss(animated: true)
//
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let entity = self.entity else {return 0}
        return entity.isCityChoising ? 40 : 100
    }
}

extension CCViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.changedCity(text: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        entity?.isCityChoising = false
        
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
        print("CC_setState")
        updateView(entity: entity)
    }
}


