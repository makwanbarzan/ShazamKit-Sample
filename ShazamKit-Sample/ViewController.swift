//
//  ViewController.swift
//  ShazamKit-Sample
//
//  Created by Makwan BK on 09/06/2021.
//

import UIKit
import ShazamKit

class ViewController: UIViewController {
    
    private var matchButton = UIButton()
    
    private let session = SHSession()
    private let signatureGenerator = SHSignatureGenerator()
    private let audioEngine = AVAudioEngine()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ShazamKit"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        var buttonConfig = UIButton.Configuration.tinted()
        buttonConfig.title = "Find Match"
        buttonConfig.image = UIImage(systemName: "music.note")
        buttonConfig.imagePadding = 5
        
        matchButton.configuration = buttonConfig
        matchButton.addTarget(self, action: #selector(matchTapped), for: .touchUpInside)
        
        view.addSubview(matchButton)
        
        matchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            matchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            matchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    func shazamConfiguration() {
        
        session.delegate = self
        
        let audioSession = AVAudioSession.sharedInstance()
        
        audioSession.requestRecordPermission { [self] granted in
            
            if !granted {
                matchButton.configuration?.title = "Permission first"
            }
            
            try! audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            let input = audioEngine.inputNode
            let recordingFormat = input.outputFormat(forBus: 0)
            input.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, time in
                
                try! signatureGenerator.append(buffer, at: nil)
                session.matchStreamingBuffer(buffer, at: nil)
                
            }
            
            audioEngine.prepare()
            try! audioEngine.start()
            
            DispatchQueue.main.async {
                matchButton.configuration?.title = "Listening..."
            }
            
        }
        
    }

    @objc func matchTapped(_ sender: UIButton) {
        shazamConfiguration()
    }

}

extension ViewController: SHSessionDelegate {
    func session(_ session: SHSession, didFind match: SHMatch) {
        guard let music = match.mediaItems.first else { return }
        
        DispatchQueue.main.async { [self] in
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ShazamDetailView") as? ShazamDetailViewController {
                
                vc.imageURL = music.artworkURL
                vc.musicName = music.title!
                vc.artistName = music.artist!
                
                present(vc, animated: true, completion: nil)
            }
        }
        
    }
}
