//
//  BlockerTableViewCell.swift
//  NoFeed
//
//  Created by Vova Seuruk on 10/26/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class BlockerTableViewCell: UITableViewCell, BlockerCell {
    
    var dataSource: BlockerCellDataProvider? {
        didSet {
            updateContent()
        }
    }
    
    var isBlockerOn: Bool {
        return switchView.isOn
    }
    
    func setBlockerIsOn(_ isOn: Bool) {
        switchView.isOn = isOn
    }
    
    func selected() {
        switchView.setOn(!switchView.isOn, animated: true)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(shadowView)
        contentView.addSubview(baseView)
        baseView.addSubview(iconView)
        baseView.addSubview(switchView)
        baseView.addSubview(titleLabel)
        baseView.layer.cornerRadius = 10.0
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: private interface
    
    private struct Constants {
        static let cornerRadius: CGFloat = 10.0
        static let baseViewVerticalOffset: CGFloat = 10.0
        static let baseViewSideOffset: CGFloat = 18.0
        static let iconViewSideOffset: CGFloat = 18.0
        static let iconViewWidth: CGFloat = 40.0
        static let labelLeftOffset: CGFloat = 30.0
        static let switchRightOffset: CGFloat = 22.0
    }
    
    private let baseView: UIView = {
        let view = UIView().viewForAutoLayout()
        view.backgroundColor = .white
        return view
    }()
    
    private let shadowView: UIView = {
        let view = ShadowView(frame: .zero).viewForAutoLayout()
        view.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.font = UIFont.avenirNextMedium(of: 18.0)
        label.textColor = UIColor.AppColors.spaceGray
        return label
    }()
    
    private let iconView: UIImageView = UIImageView().viewForAutoLayout()
    private let switchView = UISwitch().viewForAutoLayout()
    
    private func updateContent() {
        titleLabel.text = dataSource?.title
        guard let imageName = dataSource?.imageName else {
            return
        }
        iconView.image = UIImage(named: imageName)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            baseView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.baseViewSideOffset),
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.baseViewVerticalOffset),
            baseView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.baseViewSideOffset),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.baseViewVerticalOffset),
            
            iconView.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: Constants.iconViewSideOffset),
            iconView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: Constants.iconViewWidth),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: Constants.labelLeftOffset),
            titleLabel.centerYAnchor.constraint(equalTo: baseView.centerYAnchor),
            
            switchView.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: -Constants.switchRightOffset),
            switchView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor)
            ] + shadowView.constraintsWithAnchorsEqual(to: baseView))
    }
    
}
