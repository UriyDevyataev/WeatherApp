//
//  CCViewController.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import UIKit

class CCViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: CCPresenterInput!
    
    var entity = CCEntity(cityDict: [String: CityModel]())
    var cityTable = UITableView()
    var cityList = [String]()
    
    @IBAction func actionBack(_ sender: UIButton) {
        presenter.back()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        configSearcBar()
        configTableView()
    }
    
    func configSearcBar() {
        searchBar.delegate = self
        
        let textField = searchBar.searchTextField
        textField.textColor = .white
        
        guard let glassIconView = textField.leftView
                as? UIImageView else {return}
        glassIconView.tintColor = .white
    }
    
    func configTableView(){
        cityTable.backgroundColor = .clear
        cityTable.delegate = self
        cityTable.dataSource = self
        
        cityTable.register(
            UINib(nibName: "CityTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CityTableViewCellIdentifire")
        
        let height = view.frame.height - searchBar.frame.maxY
        cityTable.frame = CGRect(x: searchBar.frame.origin.x + 10,
                                 y: searchBar.frame.maxY + 2,
                                 width: searchBar.frame.width - 20,
                                 height: height)
        
        view.addSubview(cityTable)
    }
    
    func updateControls(entity: CCEntity) {
        self.entity = entity
        
        cityList.removeAll()
        entity.cityDict.forEach { (key: String, value: CityModel) in
            cityList.append(key)
        }
        DispatchQueue.main.async {
            self.cityTable.reloadData()
        }
    }
}

extension CCViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CityTableViewCellIdentifire",
            for: indexPath) as? CityTableViewCell else {
                return UITableViewCell()
            }
        
        let nameCity = cityList[indexPath.row]
        cell.cityLabel.text = nameCity
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(
            at: indexPath) as? CityTableViewCell else {return}
        
        guard let city = entity.cityDict[cell.cityLabel.text ?? ""] else {return}
        presenter.choisedCity(city: city)
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
        cityTable.isHidden = true
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

extension CCViewController: CCPresenterOutput {
    func setState(entity: CCEntity) {
        updateControls(entity: entity)
    }
}
