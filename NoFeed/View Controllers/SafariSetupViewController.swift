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
        static let playerTopOffset: CGFloat = 265.0
    }
    
    private lazy var playerViewController: AVPlayerViewController = {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = self.player
        if #available(iOS 11.0, *) {
            playerViewController.exitsFullScreenWhenPlaybackEnds = true
        }
        return playerViewController
    }()
    
    private let playerItem: AVPlayerItem? = {
        guard let path = Bundle.main.path(forResource: "instructions", ofType: "mp4") else { return nil }
        let videoUrl = URL(fileURLWithPath: path)
        return AVPlayerItem(url: videoUrl)
    }()
    
    private lazy var player: AVPlayer = {
        let player = AVPlayer(playerItem: self.playerItem)
        return player
    }()
    
    private let playImageView: UIImageView = UIImageView().viewForAutoLayout()
    
    private let placeholderImageView: UIImageView = {
        let imageView = UIImageView().viewForAutoLayout()
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let blurView: UIView = {
        let view = UIView().viewForAutoLayout()
        view.backgroundColor = UIColor(netHex: 0xDCDCDC)
        view.alpha = 0.4
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
        playImageView.image = UIImage(named: "play")
        placeholderImageView.image = UIImage(named: "safari-placeholder")
        descriptionLabel.text = "To start please follow our instruction:"
        
        placeholderImageView.addSubview(blurView)
        placeholderImageView.addSubview(playImageView)
        view.addSubview(placeholderImageView)
        view.addSubview(descriptionLabel)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onPlay))
        blurView.addGestureRecognizer(gestureRecognizer)
        
        setupConstraints()
    }
    
    @objc func onPlay() {
        if player.currentTime() != CMTime.zero {
            player.seek(to: CMTime.zero)
        }
        
        present(playerViewController, animated: true) { [weak self] in
            self?.player.play()
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constansts.descriptionTopOffset),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: Constansts.descriptionWidth),
            placeholderImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constansts.playerTopOffset),
            playImageView.centerXAnchor.constraint(equalTo: placeholderImageView.centerXAnchor),
            playImageView.centerYAnchor.constraint(equalTo: placeholderImageView.centerYAnchor)
            ] + blurView.constraintsWithAnchorsEqual(to: placeholderImageView)
        )
    }

}
