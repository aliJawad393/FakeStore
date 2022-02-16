//
//  ViewController.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import UIKit
import Combine

class ProductsListViewController: UIViewController {
    
    //MARK: Vars
    private let viewModel: ProductsListVM
    private var dataSource: UITableViewDiffableDataSource<Int, ProductsListTableViewCellViewModel>!
    private var subscriptions = [AnyCancellable]()
    
    //MARK: UIView Components
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tableFooterView = UIView()
        view.register(ProductsListTableViewCell.self, forCellReuseIdentifier: "cell")
        view.separatorInset = .zero
        view.delegate = self
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
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
        setupView()
        bindViewModel()
        setupDataSource()
        viewModel.fetchProrductsList()
    }
}

//MARK: View Setup
private extension ProductsListViewController {
    private func setupView() {
        view.addSubview(tableView)
        view.layoutSubview(tableView)
        title = "Products"
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension ProductsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView(priceObservable: viewModel.totalPrice.eraseToAnyPublisher())
    }
}

//MARK: Bind View Model
private extension ProductsListViewController {
    private func bindViewModel() {
        viewModel.productsList
            .receive(on: RunLoop.main)
            .sink {[weak self] items in
                self?.activityIndicator.stopAnimating()
                self?.appendItems(items)
            }.store(in: &subscriptions)
        
        viewModel.error
            .receive(on: RunLoop.main)
            .sink {[weak self] error  in
                self?.activityIndicator.stopAnimating()
                self?.alert("Error", message: error.localizedDescription)
            }.store(in: &subscriptions)
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, ProductsListTableViewCellViewModel>(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if let cell = cell as? ProductsListTableViewCell {
                cell.setViewModel(viewModel: itemIdentifier)
            }
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, ProductsListTableViewCellViewModel>()
        snapshot.appendSections([0])
        dataSource.apply(snapshot)
    }
    
    private func appendItems(_ items: [ProductsListTableViewCellViewModel]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot)
    }
}
