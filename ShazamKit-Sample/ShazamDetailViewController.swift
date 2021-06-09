//
//  ShazamDetailViewController.swift
//  ShazamKit-Sample
//
//  Created by Makwan BK on 09/06/2021.
//

import UIKit

class ShazamDetailViewController: UIViewController {
    
    var coverImage = UIImageView()
    var musicLabel = UILabel()
    var artistLabel = UILabel()
    
    var imageURL: URL?
    var musicName = String()
    var artistName = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        coverImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        coverImage.image = UIImage(data: try! Data(contentsOf: imageURL!))
        
        musicLabel = UILabel()
        musicLabel.text = musicName
        musicLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        musicLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        artistLabel = UILabel()
        artistLabel.text = artistName
        artistLabel.font = UIFont.preferredFont(forTextStyle: .body)
        artistLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        view.addSubview(coverImage)
        view.addSubview(musicLabel)
        view.addSubview(artistLabel)
        
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        musicLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            coverImage.heightAnchor.constraint(equalToConstant: 180),
            coverImage.widthAnchor.constraint(equalToConstant: 180),
            
            musicLabel.centerXAnchor.constraint(equalTo: coverImage.centerXAnchor),
            musicLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 30),
            
            artistLabel.centerXAnchor.constraint(equalTo: musicLabel.centerXAnchor),
            artistLabel.topAnchor.constraint(equalTo: musicLabel.bottomAnchor, constant: 10),
        ])
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
            presentationController.prefersGrabberVisible = true
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
