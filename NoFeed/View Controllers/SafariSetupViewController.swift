//
//  SafariSetupViewController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/22/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit
import AVKit

class SafariSetupViewController: UIViewController {
    
    private struct Constansts {
        static let descriptionTopOffset: CGFloat = 155.0
        static let descriptionWidth: CGFloat = 230.0
        static let playerHeight: CGFloat = 248.0
        static let playerWidth: CGFloat = 240.0
        static let playerTopOffset: CGFloat = 265.0
    }
    
    private let playerItem: AVPlayerItem? = {
        guard let path = Bundle.main.path(forResource: "instructions", ofType: "mp4") else { return nil }
        let videoUrl = URL(fileURLWithPath: path)
        return AVPlayerItem(url: videoUrl)
    }()
    
    private lazy var player: AVPlayer = {
        let player = AVPlayer(playerItem: self.playerItem)
        return player
    }()
    
    private lazy var playerLayer: AVPlayerLayer = {
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.videoGravity = .resizeAspectFill
        return playerLayer
    }()
    
    private lazy var playerView: UIView = {
        let view = UIView().viewForAutoLayout()
        view.layer.insertSublayer(self.playerLayer, at: 0)
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.numberOfLines = 0
        label.font = UIFont.avenirNextRegular(of: 24.0)
        label.textAlignment = .center
        label.textColor = UIColor.AppColors.spaceGray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        playerView.backgroundColor = .white
        descriptionLabel.text = "To start please follow our instruction:"
        
        playerLayer.frame = CGRect(x: 0, y: 0, width: Constansts.playerWidth, height: Constansts.playerHeight)
        
        view.addSubview(playerView)
        view.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constansts.descriptionTopOffset),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: Constansts.descriptionWidth),
            playerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerView.heightAnchor.constraint(equalToConstant: Constansts.playerHeight),
            playerView.widthAnchor.constraint(equalToConstant: Constansts.playerWidth),
            playerView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constansts.playerTopOffset)
            ])
    }

}
