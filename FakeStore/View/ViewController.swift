//
//  ViewController.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Vars
    private let viewModel: ProductsListVM
    
    //MARK: Init
    init(viewModel: ProductsListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

