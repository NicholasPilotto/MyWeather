//
//  MainWeatherView.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 13/11/22.
//

import UIKit

class MainWeatherView: UIView {
    
    private var gradientLayer = CAGradientLayer()
    
    override class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "--"
        label.numberOfLines = 0
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 55, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "--"
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "--"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.text = "--"
        return label
    }()
    
    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
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

        (self.layer as? CAGradientLayer)?.colors = [colorTop, colorBottom]
        (self.layer as? CAGradientLayer)?.locations = [0.0, 1.0]
        (self.layer as? CAGradientLayer)?.frame = self.bounds
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        setBackgroundColorGradient()
        addGraphicsObjects()
    }
    
    private func addGraphicsObjects() {
        self.addSubview(cityLabel)
        self.addSubview(weatherImage)
        self.addSubview(temperatureLabel)
        self.addSubview(weatherLabel)
        self.addSubview(dateLabel)
        self.addSubview(infoStack)
        
        cityLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 18, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        weatherImage.anchor(cityLabel.bottomAnchor, left: self.centerXAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: -50, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        
        infoStack.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 25, rightConstant: 0, widthConstant: 0, heightConstant: 80)
        dateLabel.anchor(nil, left: self.leftAnchor, bottom: infoStack.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 50, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        weatherLabel.anchor(nil, left: self.leftAnchor, bottom: dateLabel.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        temperatureLabel.anchor(nil, left: self.leftAnchor, bottom: weatherLabel.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 60)       
    }
    
    public func configure(viewModel: MainViewViewModel) {
        self.cityLabel.text = viewModel.city
        self.temperatureLabel.text = "\(viewModel.temperature)" + viewModel.temperatureUnit
        self.weatherImage.image = UIImage(named: viewModel.weatherImage)?.withRenderingMode(.alwaysTemplate)
        self.dateLabel.text = viewModel.date
        self.weatherLabel.text = viewModel.weather
        
        
        for element in viewModel.info {
            let infoView = ValueView()
            infoView.configure(viewModel: element)
            self.infoStack.addArrangedSubview(infoView)
        }
    }
}
