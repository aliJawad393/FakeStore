//
//  UIView+Ext.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation
import UIKit

extension UIView {
    func layoutSubview(_ subview: UIView, padding: CGFloat = 0) {
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            subview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
}


extension UIStackView {
    func addArrangedSubViews(_ subviews: [UIView]) {
        subviews.forEach {item in
            addArrangedSubview(item)
        }
    }
}
