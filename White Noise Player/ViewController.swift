//
//  ViewController.swift
//  White Noise Player
//
//  Created by Andrew Lundy on 11/29/20.
//

import UIKit
import AVFoundation

// Play and pause the white noise
// The white noise should automatically always loop
// Should be able to leave app, and have audio continue playing

class ViewController: UIViewController {
    
    //MARK: - Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Infinite White Noise"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .white
        
        return label
    }()
    
    private var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        
        return button
    }()
    
    private var audioPlayer: AVAudioPlayer!
    
    
    private var isPlaying = false
    
    //MARK: - Methods
    private func setupView() {
        view.backgroundColor = UIColor(red: 183/255, green: 65/255, blue: 14/255, alpha: 1)
        view.addSubview(titleLabel)
        view.addSubview(playButton)
        
        let whiteNoise = Bundle.main.path(forResource: "WhiteNoise.mp3", ofType: nil)!
        let whiteNoiseURL = URL(fileURLWithPath: whiteNoise)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            print("PLAYBACK OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("SESSION IS ACTIVE")
        } catch {
            print(error)
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: whiteNoiseURL)
            audioPlayer.numberOfLoops = -1
        } catch {
            print(error)
        }
        
        applyAutoConstraints()
    }
    
    private func applyAutoConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 44 + 25),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func buttonPressed() {
        if isPlaying {
            isPlaying.toggle()
            playButton.setTitle("Play", for: .normal)
            audioPlayer.pause()
        } else {
            isPlaying.toggle()
            playButton.setTitle("Stop", for: .normal)
            audioPlayer.play()
        }
    }
    
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }


}

