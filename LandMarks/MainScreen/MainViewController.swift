////
////  MainViewController.swift
////  LandMarks
////
////  Created by Антон Скуратов on 16.12.2021.
////

import Foundation
import UIKit
import SnapKit

class MainViewController : UIViewController {
    
    var favoriteState = false
    var landmarksArray = [Landmark]()
    var sortedLandmarksArray = [Landmark]()
    
    //MARK:- UI
    var tableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    var switcher: UISwitch =  {
        var switcher = UISwitch()
        switcher.setOn(false, animated: false)
        switcher.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        return switcher
    }()
    
    //MARK:- VC life сycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addToView()
        addDelegate()
        RegisterCell()
        sortedLandmarksArray(arrays: landmarksArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backButtonTitle = "Landmarks"
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraints()
    }
    
    //MARK:- Metods
    private func configure(){
        view.backgroundColor = .white
    }
    
    private func addToView(){
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(50)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.center.equalTo(view)
        }
    }
    
    private func addDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func RegisterCell() {
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: "placeCell")
        tableView.register(HeaderTableView.self, forHeaderFooterViewReuseIdentifier: "HeaderTableView")
    }
    
    private func sortedLandmarksArray(arrays:[Landmark]) {
        for i in arrays{
            if i.isFavorite {
                self.sortedLandmarksArray.append(i)
            }
        }
    }
    
    //MARK:- @objc Metods
    @objc func changeValue (_ sender: UISwitch!) {
        if (sender.isOn){
            favoriteState = true
            tableView.reloadData()
        }
        else{
            favoriteState = false
            tableView.reloadData()
        }
    }
    
    //MARK:- parsing json
    func FetchingData() {
    
            guard let path = Bundle.main.path(forResource: "landmarkData", ofType: "json") else {return}
            let url = URL(fileURLWithPath: path)
            URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
                guard let data = data, error == nil else {return}
                do{
                    let landmarksArray =  try JSONDecoder().decode([Landmark].self, from: data)
                    self?.landmarksArray = landmarksArray
                }catch{
                    print(error)
                }
            }.resume()
        }
    }
    


//MARK:- Extensions
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch favoriteState {
        case true: return sortedLandmarksArray.count
        case false : return landmarksArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as? PlaceTableViewCell else {return UITableViewCell()}
        
        switch favoriteState {
        case true: cell.setup(data: sortedLandmarksArray, indexPath: indexPath)
        case false :cell.setup(data: landmarksArray, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableView") as? HeaderTableView else {return UIView()}
        headerCell.addSubview(switcher)
        switcher.snp.makeConstraints { (make) in
            make.bottom.equalTo(headerCell.snp.top).offset(90)
            make.right.equalTo(headerCell.snp.right).offset(-30)
        }
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mapScreen = MapViewController()
        
        navigationController?.pushViewController(mapScreen, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch favoriteState {
        case true: mapScreen.updateUI(data: sortedLandmarksArray, indexPath: indexPath)
        case false : mapScreen.updateUI(data: landmarksArray, indexPath: indexPath)
        }
    }
    
    
}

