//
//  MainWeatherView.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 13/11/22.
//

import UIKit

class MainWeatherView: UIView {
    
    private var gradientLayer = CAGradientLayer()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        return image
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 55, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .center
        return label
    }()
    
    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBackgroundColorGradient() {
        let colorTop = UIColor(rgb: 0x15C1F4).cgColor
        let colorBottom = UIColor(rgb: 0x1182FA).cgColor

        self.gradientLayer.colors = [colorTop, colorBottom]
        self.gradientLayer.locations = [0.0, 1.0]
        self.gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        setBackgroundColorGradient()
        addGraphicsObjects()
    }
    
    private func addGraphicsObjects() {
        cityLabel.frame = CGRect(x: 0, y: 18, width: self.frame.width, height: 30)
        weatherImage.frame = CGRect(x: (self.frame.width / 2) - 75, y: 18 + 30 + 75, width: 150, height: 150)
        temperatureLabel.frame = CGRect(x: 0, y: 18 + 30 + 75 + 150 + 45, width: self.frame.width, height: 60)
        weatherLabel.frame = CGRect(x: 0, y: 18 + 30 + 75 + 150 + 45 + 60 + 5, width: self.frame.width, height: 30)
        dateLabel.frame = CGRect(x: 0, y: 18 + 30 + 75 + 150 + 45 + 60 + 5 + 30, width: self.frame.width, height: 20)
        infoStack.frame = CGRect(x: 10, y: self.bottom - 175, width: self.width - 20, height: 80)
        addInfoView()
        
        self.addSubview(cityLabel)
        self.addSubview(weatherImage)
        self.addSubview(temperatureLabel)
        self.addSubview(weatherLabel)
        self.addSubview(dateLabel)
        self.addSubview(infoStack)
    }
    
    public func addInfoView() {
        let windInfoView = ValueView()
        let humidityInfoView = ValueView()
        let rainInfoView = ValueView()
        
        infoStack.addArrangedSubview(windInfoView)
        infoStack.addArrangedSubview(humidityInfoView)
        infoStack.addArrangedSubview(rainInfoView)
    }
}
