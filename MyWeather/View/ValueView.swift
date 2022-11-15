//
//  ValueView.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 15/11/22.
//

import UIKit

class ValueView: UIView {

    private let icon: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(icon)
        self.addSubview(valueLabel)
        self.addSubview(infoLabel)
        
        icon.frame = CGRect(x: (self.width / 2) - 15, y: 0, width: 30, height: 30)
        valueLabel.frame = CGRect(x: 0, y: icon.bottom + 5, width: self.width, height: 20)
        infoLabel.frame = CGRect(x: 0, y: valueLabel.bottom + 5, width: self.width, height: 20)
    }
}
