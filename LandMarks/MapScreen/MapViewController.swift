//
//  MapViewController.swift
//  LandMarks
//
//  Created by Антон Скуратов on 17.12.2021.
//

import Foundation
import UIKit
import SnapKit
import MapKit

final class MapViewController : UIViewController, MKMapViewDelegate{
    
    //MARK:- UI
    private var mapView: MKMapView = {
        var map = MKMapView()
        return map
    }()
    
    var baseView : UIView = {
        var baseView = UIView()
        baseView.backgroundColor = UIColor.clear
        baseView.layer.shadowColor = UIColor.black.cgColor
        baseView.layer.shadowOffset = CGSize(width: 3, height: 3)
        baseView.layer.shadowOpacity = 0.7
        baseView.layer.shadowRadius = 6.0
        return baseView
    }()
    
    var borderView : UIView = {
        var borderView = UIView()
        borderView.layer.cornerRadius = 100
        borderView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        borderView.layer.borderWidth = 4.0
        borderView.layer.masksToBounds = true
        return borderView
    }()
    
    var image : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 100
        image.layer.masksToBounds = true
        return image
    }()

    var nameLabel : UILabel = {
        var label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Arial", size: 30)
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    var parkLabel : UILabel = {
        var label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Arial", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    var stateLabel : UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Arial", size: 17)
        label.text = ""
        return label
    }()
    
    lazy var star: UIImageView = {
        var star = UIImageView()
        star.image = UIImage(systemName: "star.fill")
        star.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        star.contentMode = .scaleAspectFill
        star.layer.masksToBounds = true
        star.isHidden = true
        return star
    }()
    
    //MARK:- VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addUI()
        addConstraint()
        addDelegate()
        navigationItem.backButtonTitle = "Landmarks"
       
        
        
    }
    //MARK:- Metods
    private func configure(){
        view.backgroundColor = #colorLiteral(red: 0.9752815366, green: 0.9694834352, blue: 0.9797381759, alpha: 1)
        navigationController?.isNavigationBarHidden = false
    }
    private func addUI(){
        view.addSubview(mapView)
        view.addSubview(baseView)
        baseView.addSubview(borderView)
        borderView.addSubview(image)
        view.addSubview(nameLabel)
        view.addSubview(parkLabel)
        view.addSubview(stateLabel)
        view.addSubview(star)
        
    }
    private func addConstraint() {
        mapView.snp.makeConstraints { (mapView) in
            mapView.bottom.equalTo(view.snp.centerY)
            mapView.left.equalTo(view.snp.left)
            mapView.right.equalTo(view.snp.right)
            mapView.top.equalTo(view.snp.top)
        }
        baseView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        borderView.snp.makeConstraints { (make) in
            make.centerX.equalTo(baseView.snp.centerX)
            make.centerY.equalTo(baseView.snp.centerY)
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        image.snp.makeConstraints { (make) in
            make.centerX.equalTo(borderView.snp.centerX)
            make.centerY.equalTo(borderView.snp.centerY)
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        nameLabel.snp.makeConstraints { (nameLabel) in
            nameLabel.left.equalTo(view.snp.left).offset(10)
            nameLabel.top.equalTo(baseView.snp.bottom).offset(20)
        }
        parkLabel.snp.makeConstraints { (parkLabel) in
            parkLabel.left.equalTo(view.snp.left).offset(10)
            parkLabel.top.equalTo(nameLabel.snp.bottom).offset(7)
            parkLabel.width.equalTo(300)
        }
        stateLabel.snp.makeConstraints { (stateLabel) in
            stateLabel.right.equalTo(view.snp.right).offset(-10)
            stateLabel.centerY.equalTo(parkLabel.snp.centerY)
        }
        star.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(10)
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
    
    private func addDelegate() {
        mapView.delegate = self
    }
    
    func updateUI(data: [Landmark], indexPath: IndexPath) {
        navigationItem.title = data[indexPath.row].name
        image.image = UIImage(named: data[indexPath.row].imageName)
        setupMap(Lat: data[indexPath.row].coordinates.latitude,
                 long:  data[indexPath.row].coordinates.longitude)
        nameLabel.text = data[indexPath.row].name
        parkLabel.text = data[indexPath.row].park
        stateLabel.text = data[indexPath.row].state
        switch data[indexPath.row].isFavorite{
        case true: star.isHidden = false
        case false: star.isHidden = true
        }
    }
    
    private func setupMap(Lat:Double,long: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: Lat, longitude: long)
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate,
                                        latitudinalMeters: 5000,
                                        longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
    }
}


