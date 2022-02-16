//
//  FooterView.swift
//  FakeStore
//
//  Created by Ali Jawad on 17/02/2022.
//

import Foundation
import UIKit
import Combine

final class FooterView: UIView {
    
    //MARK: Vars
    private var subscriptions = [AnyCancellable]()
    
    //MARK: UIView Components
    private lazy var labelText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.montserratMedium.withAdjustableSize(18)
        view.textAlignment = .center
        return view
    }()
    
    //MARK: Init
    
    init(lastSyncDateObservable: AnyPublisher<String, Never>) {
        super.init(frame: .zero)
        setupView()
        observeLastSyncDate(lastSyncDateObservable)
        
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
    private func observeLastSyncDate(_ observable: AnyPublisher<String, Never>) {
        observable
            .receive(on: RunLoop.main)
            .sink { lastSyncDate in
                self.labelText.text = "Last sync date: \(lastSyncDate)"
            }.store(in: &subscriptions)
    }

}
