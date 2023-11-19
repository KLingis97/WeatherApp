//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Kyriakos Lingis on 19/11/2023.
//

import Foundation
import UIKit
import SnapKit

class WeatherDetailView: UIView {
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    
    init(title: String, value: String) {
        super.init(frame: .zero)
        setupView(title: title, value: value)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(title: String, value: String) {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        titleLabel.text = title
        titleLabel.textColor = .white
        valueLabel.text = value
        valueLabel.textColor = .white
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        self.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        backgroundColor = UIColor(white: 0.2, alpha: 0.8)
        layer.cornerRadius = 10
    }
    
    func update(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
