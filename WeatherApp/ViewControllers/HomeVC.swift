//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kyriakos Lingis on 18/11/2023.
//

import UIKit
import CoreLocation

class HomeVC: UIViewController {
    
    var vm: HomeviewVM!
    var homeView: WeatherHomeView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            
            vm = HomeviewVM()
            vm.fetchCurrentWeatherData(lat: lat, lon: lon) { success in
                if success {
                    self.vm.fetchImageFromUrl() { success in
                        if success {
                            self.homeView = WeatherHomeView(vm: self.vm, frame: CGRect.zero)
                            self.view.addSubview(self.homeView)
                            self.homeView.snp.makeConstraints { (make) in
                                make.edges.equalTo(self.view)
                            }
                        } else {
                            print("Error fetching current weather icon")
                        }
                        
                    }
                    
                } else {
                    print("Error fetching weather data")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location access was denied.")
        default:
            break
        }
    }
}

extension HomeVC: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("When user did not yet determined")
        case .restricted:
            print("Restricted by parental control")
        case .denied:
            print("When user select option Dont't Allow")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            print("When user select option Allow While Using App or Allow Once")
        default:
            print("default")
        }
    }
}

