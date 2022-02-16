//
//  ProductsListTableViewCell.swift
//  FakeStore
//
//  Created by Ali Jawad on 15/02/2022.
//

import Foundation
import UIKit
import SDWebImage

final class ProductsListTableViewCell: UITableViewCell {
    
    //MARK: Vars
    private var cancellable: Cancellable?
    private var viewModel: ProductsListTableViewCellViewModel?
    
    //MARK: UIView Components
    private lazy var verticalStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 20
        view.addArrangedSubViews([labelTitle, imageViewPost, viewsSideBySide(leftView: labelCategory, rightView: adjacentViews(leftView: buttonAddRemove, rightView: labelPrice)), labelDescription])
        return view
    }()
    
    private lazy var labelTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.montserratMedium.withSize(20)
        return view
    }()
    
    private lazy var imageViewPost: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var labelPrice: UILabel = {
        let view = UILabel()
        view.font = UIFont.montserratLight.withSize(15)
        view.textAlignment = .right
        return view
    }()
    
    private lazy var labelDescription: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .left
        view.font = UIFont.montserratMedium.withSize(16)
        return view
    }()
    
    private lazy var labelCategory: UILabel = {
        let view = UILabel()
        view.font = UIFont.montserratLight.withSize(15)
        view.textAlignment = .left
        return view
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    private lazy var buttonAddRemove: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Add", for: .normal)
        view.titleLabel?.font = UIFont.montserratMedium.withAdjustableSize(20)
        view.setTitleColor(.systemCyan, for: .normal)
        return view
    }()
    
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup View
    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(verticalStack)
        contentView.addSubview(loadingIndicator)
        contentView.layoutSubview(verticalStack, padding: 20)
        NSLayoutConstraint.activate([
            imageViewPost.heightAnchor.constraint(equalTo: imageViewPost.widthAnchor, multiplier: 1),
            loadingIndicator.centerXAnchor.constraint(equalTo: imageViewPost.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: imageViewPost.centerYAnchor),
        ])
    }
    
    //MARK: Internal Methods
    func setViewModel(viewModel: ProductsListTableViewCellViewModel) {
        self.viewModel = viewModel
        self.setData(data: viewModel.product)
    }
}

//MARK: Private Heplers
private extension ProductsListTableViewCell {
    private func setData(data: ProductPresenter) {
        labelTitle.text = data.title
        labelPrice.text = data.price
        labelDescription.text = data.description
        labelCategory.text = data.category
        imageViewPost.sd_setImage(with: data.imageURL, placeholderImage: nil, options: [SDWebImageOptions.progressiveLoad], context: nil)
    }
    
    private func viewsSideBySide(leftView: UIView, rightView: UIView) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubViews([leftView,
                                       UIView(),
                                      rightView])
        return stackView
    }
    
    private func adjacentViews(leftView: UIView, rightView: UIView) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.addArrangedSubViews([leftView,
                                      rightView])
        return stackView
    }
}
