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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var connectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    deinit {
//        print("deinit CCViewController")
    }
    func config() {
        configUI()
        configSearcBar()
        configTableView()
        presenter.viewIsReady()
    }
    
    func configUI(){
        self.view.backgroundColor = .black
        titleLabel.text = R.string.localizable.titleLabel()
    }
    
    func configSearcBar() {
        searchBar.delegate = self
        
        //textField
        let textField = searchBar.searchTextField
        textField.textColor = .white
        textField.backgroundColor = .darkGray
        
        let attributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributedText = NSMutableAttributedString(
            string: R.string.localizable.searhBarPlaceholder(),
            attributes: attributes)
        textField.attributedPlaceholder = attributedText
        
        //placeholder
        guard let glassIconView = textField.leftView
                as? UIImageView else {return}
        glassIconView.tintColor = .lightGray
        
        //button
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = R.string.localizable.searhBarClear()
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
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
        
        DispatchQueue.main.async {
            self.connectLabel.isHidden = true
        }
        
        switch entity.isCityChoising {
        case true:
            if let dict = entity.cityDict {
                cityList.removeAll()
                dict.forEach { (key: String, value: CityModel) in
                    cityList.append(key)
                }
            } else {
                DispatchQueue.main.async {
                    self.connectLabel.text = R.string.localizable.connectLabel()
                    self.connectLabel.isHidden = false
                }
            }
        case false:
            weatherList = entity.weatherList ?? [CWEntity]()
            DispatchQueue.main.async {
                self.clearSearch()
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func clearSearch() {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    private func fill(cell: WeatherTableViewCell, withContent: CWEntity) -> UITableViewCell {
        guard let weather = withContent.weather else {return UITableViewCell()}
                
        let cityName = withContent.city.name
        let time = weather.timezone_offset.strTimeFromNow()
        let temp = "\(weather.current.temp.rounded())\u{00B0}"
        let maxTemp = String(weather.daily[0].temp.max.rounded())
        let minTemp = String(weather.daily[0].temp.min.rounded())
        let maxMinTemp = R.string.localizable.maxMinLabel(maxTemp, minTemp)

        let lang = Locale.preferredLanguages.first?.dropLast(3).description
        var info = ""
        
        if let alerts = weather.alerts {
            if lang == "en" {
                info = alerts[0].event
            } else {
                info = alerts.count > 1 ? alerts[1].event : alerts[0].event
            }
        } else {
            info = weather.current.weather[0].description.capitalizingFirstLetter()
        }

        cell.cityLabel.text = cityName
        cell.timeLabel.text = time
        cell.tempLabel.text = temp
        cell.infoLabel.text = info
        cell.maxMinTempLabel.text = maxMinTemp
        cell.configBackgroud(withContent.background)
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
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
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
            presenter.changedSearch(city: city)
        case false:
            presenter.choisedCity(index: indexPath.row)
            self.dismiss(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0 {
            if editingStyle == .delete {
                presenter.deleteCity(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let entity = self.entity else {return 0}
        return entity.isCityChoising ? 40 : 120
    }
}

extension CCViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let lang = searchBar.textInputMode?.primaryLanguage ?? "en"
        presenter.changedSearch(text: searchText, lang: lang)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        entity?.isCityChoising = false
        clearSearch()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.connectLabel.isHidden = true
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CCViewController: CCPresenterOutput {
    func setState(entity: CCEntity) {
//        print("CC_setState - \(Date.now)")
        updateView(entity: entity)
    }
}
