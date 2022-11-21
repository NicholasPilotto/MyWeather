//
//  ValueView.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 15/11/22.
//

import UIKit

class ValueView: UIView {

    private var icon: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
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
        
        icon.anchor(self.topAnchor, left: self.centerXAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: -15, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        valueLabel.anchor(icon.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        infoLabel.anchor(valueLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
    }
    
    public func setIcon(icon: String) {
        self.icon.image = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
    }

}
