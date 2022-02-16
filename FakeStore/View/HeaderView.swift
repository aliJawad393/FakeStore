//
//  HeaderView.swift
//  FakeStore
//
//  Created by Ali Jawad on 16/02/2022.
//

import Foundation
import UIKit
import Combine

final class HeaderView: UIView {
    
    //MARK: Vars
    private var subscriptions = [AnyCancellable]()
    
    //MARK: UIView Components
    private lazy var labelText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.montserratMedium.withAdjustableSize(18)
        view.textAlignment = .right
        return view
    }()
    
    //MARK: Init
    
    init(priceObservable: AnyPublisher<Float, Never>) {
        super.init(frame: .zero)
        setupView()
        observeTotalPrice(priceObservable)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Setup
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(labelText)
        layoutSubview(labelText, padding: 10)
    }
    
    //MARK: Private Helper
    private func observeTotalPrice(_ observable: AnyPublisher<Float, Never>) {
        observable
            .receive(on: RunLoop.main)
            .sink { totalPrice in
                self.labelText.text = "Total: \(String(format: "%.2f", totalPrice))"
            }.store(in: &subscriptions)
    }

}
