//
//  OnboardingViewController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/4/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit
import Crashlytics

class OnboardingViewController: UIViewController {
    
    enum ControllerType {
        case image, table
    }
    
    private let type: ControllerType
    fileprivate let tableDataSource: OnboardingTableDataProvider?
    
    private let descriptionLabelRatio: CGFloat = 0.8404
    private let rowHeight: CGFloat = 95.0
    fileprivate let blockerCellReuseIdentifier = "blockerCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.font = UIFont.avenirNextMedium(of: 21.5)
        label.textColor = UIColor.AppColors.darkGray
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.numberOfLines = 0
        label.font = UIFont.avenirNextRegular(of: 16.0)
        label.textColor = UIColor.AppColors.darkGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain).viewForAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BlockerTableViewCell.self, forCellReuseIdentifier: blockerCellReuseIdentifier)
        tableView.bounces = false
        tableView.backgroundColor = .white
        tableView.rowHeight = rowHeight
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView().viewForAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        return imageView
    }()
    
    convenience init(with image: UIImage?, title: String, description: String) {
        self.init(with: .image, title: title, description: description)
        imageView.image = image
    }
    
    init(with type: ControllerType, dataSource: OnboardingTableDataProvider? = nil, title: String, description: String) {
        self.type = type
        self.tableDataSource = dataSource
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        let viewToAdd = isImageType ? imageView : tableView
        view.addSubview(viewToAdd)
        
        setupConstraints()
    }
    
    private var isImageType: Bool {
        return type == .image
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200.0),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18.0),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: descriptionLabelRatio)
            ])
        
        if isImageType {
            NSLayoutConstraint.activate([
                imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
                imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
                imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0)
                ])
        } else {
            guard let rowsCount = tableDataSource?.numberOfItems() else { return }
            NSLayoutConstraint.activate([
                tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 155.0),
                tableView.heightAnchor.constraint(equalToConstant: rowHeight * CGFloat(rowsCount))
                ])
        }
    }

}

extension OnboardingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource?.numberOfItems() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: blockerCellReuseIdentifier, for: indexPath)
        
        guard let blockerCell = cell as? BlockerTableViewCell else {
            return cell
        }
        blockerCell.dataSource = tableDataSource?.model(at: indexPath)
        
        return cell
    }
    
}

extension OnboardingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let blockerCell = tableView.cellForRow(at: indexPath) as? BlockerTableViewCell else {
            return
        }
        blockerCell.selected()
    }
    
}
