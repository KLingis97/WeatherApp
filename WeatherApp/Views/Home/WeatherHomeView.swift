//
//  HomeView.swift
//  WeatherApp
//
//  Created by Kyriakos Lingis on 19/11/2023.
//

import UIKit
import SnapKit

class WeatherHomeView: UIView {
    
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    let settingsButton = UIButton()
    let menuButton = UIButton()
    let temperatureButton = UIButton()
    
    let weatherIconImageView = UIImageView()
    let temperatureLabel = UILabel()
    let cityNameLabel = UILabel()
    let weatherDescriptionLabel = UILabel()
    
    let locationStackView = UIStackView()
    let tempStackView = UIStackView()
    let detailsStackView = UIStackView()
    let horizontalStackView = UIStackView()
    var feelsLikeView: WeatherDetailView!
    var humidityView: WeatherDetailView!
    var uvIndexView: WeatherDetailView!
    var windSpeedView: WeatherDetailView!
    var cloudsView: WeatherDetailView!
    var rainView: WeatherDetailView?
    var snowView: WeatherDetailView?
    
    let latTextField = UITextField()
    let lonTextField = UITextField()
    
    let textColor = UIColor.white
    let detailBackgroundColor = UIColor(white: 0.2, alpha: 0.8)
    
    var viewModel: HomeviewVM? {
        didSet {
            updateTemp()
        }
    }
    
    init(vm: HomeviewVM, frame: CGRect) {
        super.init(frame: frame)
        viewModel = vm
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        guard let viewModel = viewModel else { return }
        
        let timezone: String = viewModel.weatherData?.timezone ?? ""
        var city: String = ""
        if let index = timezone.firstIndex(of: "/") {
            city = String(timezone[timezone.index(after: index)...])
            city = city.replacingOccurrences(of: "_", with: " ")
        }
        cityNameLabel.text = city
        
        temperatureLabel.text = String(format: "%.1lf", viewModel.weatherData?.current?.temp ?? 0) + (viewModel.selectedTemperature == .celsius ? "°C" : "°F")
        
        weatherDescriptionLabel.text = viewModel.weatherData?.current?.weather[0].main
        weatherIconImageView.image = viewModel.currentWeatherIcon
        
        let feels_like = String(format: "%.1lf", viewModel.weatherData?.current?.feels_like ?? 0) + (viewModel.selectedTemperature == .celsius ? "°C" : "°F")
        feelsLikeView.update(title: "Feels like", value: feels_like)
        
        let humidity = (viewModel.weatherData?.current?.humidity.description ?? "") + "%"
        humidityView.update(title: "Humidity", value: humidity)
        
        let uvIndex = viewModel.weatherData?.current?.uvi.description ?? ""
        uvIndexView.update(title: "UV Index", value: uvIndex)
        
        let windSpeed = (viewModel.weatherData?.current?.wind_speed.description ?? "") + " m/s"
        windSpeedView.update(title: "Wind speed", value: windSpeed)
        
        let clouds = (viewModel.weatherData?.current?.clouds.description ?? "") + "%"
        cloudsView.update(title: "Clouds", value: clouds)
        
    }
    
    func updateTemp() {
        guard let viewModel = viewModel else { return }
        
        temperatureLabel.text = String(format: "%.1lf", viewModel.weatherData?.current?.temp ?? 0) + (viewModel.selectedTemperature == .celsius ? "°C" : "°F")
        
        let feels_like: String = String(format: "%.1lf", viewModel.weatherData?.current?.feels_like ?? 0) + (viewModel.selectedTemperature == .celsius ? "°C" : "°F")
        
        feelsLikeView.update(title: "Feels like", value: feels_like)
    }
    
    private func setupViews() {
        
        self.backgroundColor = UIColor(white: 0.7, alpha: 1.0)
        guard let viewModel = viewModel else { return }
        
        activityIndicator.center = self.center
        activityIndicator.color = UIColor(white: 1, alpha: 1)
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
        
        
        let latLabel = UILabel()
        latLabel.text = "latitude:"
        latLabel.textColor = textColor
        
        latTextField.layer.cornerRadius = 10
        latTextField.placeholder = "lat..."
        latTextField.backgroundColor = detailBackgroundColor
        latTextField.textColor = textColor
        
        let lonLabel = UILabel()
        lonLabel.text = "longitude:"
        lonLabel.textColor = textColor
        
        lonTextField.layer.cornerRadius = 10
        latTextField.placeholder = "lon..."
        lonTextField.backgroundColor = detailBackgroundColor
        lonTextField.textColor = textColor
        
        let goButton = UIButton()
        goButton.setTitle("Go", for: .normal)
        goButton.backgroundColor = UIColor(white: 0.2, alpha: 0.8)
        goButton.setTitleColor(.white, for: .normal)
        goButton.layer.cornerRadius = 10
        goButton.addTarget(self, action: #selector(self.fetchNewWeatherData), for: .touchUpInside)
        
        locationStackView.axis = .horizontal
        locationStackView.spacing = 5
        locationStackView.distribution = .equalCentering
        
        locationStackView.addArrangedSubview(latLabel)
        locationStackView.addArrangedSubview(latTextField)
        locationStackView.addArrangedSubview(lonLabel)
        locationStackView.addArrangedSubview(lonTextField)
        locationStackView.addArrangedSubview(goButton)
        
        addSubview(locationStackView)
        
        temperatureButton.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        temperatureButton.tintColor = .white
        temperatureButton.backgroundColor =  UIColor(white: 0.2, alpha: 0.8)
        temperatureButton.setTitleColor(.white, for: .normal)
        temperatureButton.layer.cornerRadius = 10
        temperatureButton.addTarget(self, action: #selector(self.toggleTemperatureUnit), for: .touchUpInside)
        temperatureButton.sizeToFit()
        
        temperatureLabel.text = String(format: "%.1lf", viewModel.weatherData?.current?.temp ?? 0) + (viewModel.selectedTemperature == .celsius ? "°C" : "°F")
        temperatureLabel.textColor = textColor
        
        let timezone: String = viewModel.weatherData?.timezone ?? ""
        var city: String = ""
        if let index = timezone.firstIndex(of: "/") {
            city = String(timezone[timezone.index(after: index)...])
            city = city.replacingOccurrences(of: "_", with: " ")
        }
        cityNameLabel.text = city
        cityNameLabel.textColor = textColor
        
        weatherDescriptionLabel.text = viewModel.weatherData?.current?.weather[0].main
        weatherDescriptionLabel.textColor = textColor.withAlphaComponent(1)
        
        weatherIconImageView.image = viewModel.currentWeatherIcon
        
        tempStackView.axis = .horizontal
        tempStackView.spacing = 5
        tempStackView.distribution = .fillProportionally
        tempStackView.addArrangedSubview(temperatureLabel)
        tempStackView.addArrangedSubview(temperatureButton)
        
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        verticalStackView.distribution = .fillProportionally
        
        verticalStackView.addArrangedSubview(tempStackView)
        verticalStackView.addArrangedSubview(cityNameLabel)
        verticalStackView.addArrangedSubview(weatherDescriptionLabel)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.distribution = .fillProportionally
        
        horizontalStackView.addArrangedSubview(weatherIconImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        addSubview(horizontalStackView)
        
        addSubview(detailsStackView)
        detailsStackView.axis = .vertical
        detailsStackView.distribution = .fillEqually
        detailsStackView.spacing = 10
        
        let feels_like: String = String(format: "%.1lf", viewModel.weatherData?.current?.feels_like ?? 0) + (viewModel.selectedTemperature == .celsius ? "°C" : "°F")
        let humidity: String = (viewModel.weatherData?.current?.humidity.description ?? "") + "%"
        let uvIndex: String = viewModel.weatherData?.current?.uvi.description ?? ""
        let windSpeed: String = (viewModel.weatherData?.current?.wind_speed.description ?? "") + " m/s"
        let clouds: String = (viewModel.weatherData?.current?.clouds.description ?? "") + "%"
        
        feelsLikeView = WeatherDetailView(title: "Feels like", value: feels_like)
        humidityView = WeatherDetailView(title: "Humidity", value: humidity)
        uvIndexView = WeatherDetailView(title: "UV Index", value: uvIndex)
        windSpeedView = WeatherDetailView(title: "Wind speed", value: windSpeed)
        cloudsView = WeatherDetailView(title: "Clouds", value: clouds)
        
        detailsStackView.addArrangedSubview(feelsLikeView)
        detailsStackView.addArrangedSubview(humidityView)
        detailsStackView.addArrangedSubview(uvIndexView)
        detailsStackView.addArrangedSubview(windSpeedView)
        detailsStackView.addArrangedSubview(cloudsView)
        
        if let rain = viewModel.weatherData?.current?.rain {
            let rain: String = (rain.perHour?.description ?? "") + "mm/h"
            rainView = WeatherDetailView(title: "Rain", value: rain)
            detailsStackView.addArrangedSubview(rainView!)
        }
        if let snow = viewModel.weatherData?.current?.snow {
            let snow: String = (snow.perHour?.description ?? "") + "mm/h"
            snowView = WeatherDetailView(title: "Rain", value: snow)
            detailsStackView.addArrangedSubview(snowView!)
        }
        
    }
    
    @objc func toggleTemperatureUnit() {
        guard let viewModel else { return }
        viewModel.convertTemperature(temperatureType: viewModel.selectedTemperature)
        updateTemp()
    }
    
    @objc func fetchNewWeatherData() {
        guard let viewModel else { return }
        
        let lat = latTextField.text ?? ""
        let lon = lonTextField.text ?? ""
        
        latTextField.text = ""
        lonTextField.text = ""
        
        self.showLoadingIndicator()
        
        viewModel.fetchCurrentWeatherData(lat: lat, lon: lon, completion: { success in
            if success {
                viewModel.fetchImageFromUrl(completion: { success in
                    if success {
                        self.updateView()
                        self.hideLoadingIndicator()
                    } else {
                        print("error fetching current weather icon")
                        self.hideLoadingIndicator()
                    }
                })
                
            } else {
                print("error fetching weather data")
                self.hideLoadingIndicator()
            }
        })
        
    }
    
    private func setupConstraints() {
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        locationStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(50)
            make.left.right.equalToSuperview().inset(16)
        }
        
        latTextField.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        lonTextField.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(locationStackView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        weatherIconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100)) // Adjust size as needed
        }
        
        temperatureButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(5)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityNameLabel.snp.bottom).offset(5)
        }
        
        detailsStackView.snp.makeConstraints { make in
            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            
        }
        
    }
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
}

