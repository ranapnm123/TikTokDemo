//
//  HomeFeedCell.swift
//  KoolStoriesDemo
//
//  Created by Ravi Rana on 30/06/21.
//

import UIKit
import AVFoundation

class HomeFeedCell: UICollectionViewCell {
    @IBOutlet weak var playerView: VideoPlayerView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var averagePointsButton: UIButton!
    @IBOutlet weak var collaboratorImageButton: UIButton!
    @IBOutlet weak var collaboratorButton: UIButton!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var minRateLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var maxRateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: ExpandableLabel!
    @IBOutlet weak var totalKoolsLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    var model:VideoModel?
    var commentActionCallback:(()->())?
    var shareActionCallback:(()->())?
    var profileActionCallback:(()->())?
    var collaboratorActionCallback:(()->())?
    
    let gradientLayer = CAGradientLayer()
    
    func setupData(data:VideoModel) {
        self.model = data
        
        ratingSlider.setThumbImage(#imageLiteral(resourceName: "logo"), for: .normal)
        self.ratingSlider.setThumbImage(#imageLiteral(resourceName: "logo_large"), for: .highlighted)
        ratingSlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        ratingSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        
        profileButton.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        averagePointsButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let image = UIImage(named: data.userProfilePicture!)
        profileButton.setImage(image, for: .normal)
        usernameButton.setTitle(data.username!, for: .normal)
        averagePointsButton.setTitle("\(data.averageRating ?? 0)", for: .normal)
        commentsCountLabel.text = "\(data.commentsCount ?? 0)"
        totalKoolsLabel.text = "\(data.koolsCount ?? 0)"
        
        
        descriptionLabel.setLessLinkWith(lessLink: "Close", attributes: [.foregroundColor:UIColor.red], position: .left)
        self.layoutIfNeeded()
        descriptionLabel.delegate = self
        descriptionLabel.shouldCollapse = true
        descriptionLabel.text = data.description ?? ""
        
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        playerView.contentMode = .scaleAspectFill
        
        setGradientBackground()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.collapsed = true
        descriptionLabel.text = nil
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor.black.withAlphaComponent(0.0).cgColor
        let colorBottom = UIColor.black.withAlphaComponent(1.0).cgColor
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = gradientView.bounds
        
        gradientView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    @IBAction func ratingAction(_ sender: Any) {
        maxRateLabel.text = "\(Int(ratingSlider.value))"
    }
    
    func playVideo(){
        
        debugPrint("play video>>>>")
        let video = self.model?.videoName
        
        guard let path = Bundle.main.path(forResource: video, ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        let url = URL(fileURLWithPath: path)
        
        playerView?.play(for: url)
        
    }
    
    func stopVideo() {
        debugPrint("stop video>>>>")
        playerView?.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(exactly: 1000000000)!), completion: { (success) in
            if success == true{
                self.playerView?.pause(reason: .hidden)
            }
        })
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                // handle drag began
                debugPrint("began")
            case .moved:
                // handle drag moved
                debugPrint("moved")
            case .ended:
                // handle drag ended
                debugPrint("ended")
            default:
                debugPrint("default")
                break
            }
        }
    }
    
    
    @IBAction func commentAction() {
        commentActionCallback?()
    }
    
    @IBAction func shareAction() {
        shareActionCallback?()
    }
    
    @IBAction func profileAction() {
        profileActionCallback?()
    }
    
    @IBAction func collaboratorAction() {
        collaboratorActionCallback?()
    }
    
}

extension HomeFeedCell: ExpandableLabelDelegate {
    func willExpandLabel(_ label: ExpandableLabel) {
    }
    
    func didExpandLabel(_ label: ExpandableLabel) {
        gradientView.setNeedsLayout()
        gradientView.layoutIfNeeded()
    }
    
    func willCollapseLabel(_ label: ExpandableLabel) {
    }
    
    func didCollapseLabel(_ label: ExpandableLabel) {
    }
    
    
}
