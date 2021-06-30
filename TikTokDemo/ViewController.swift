//
//  ViewController.swift
//  KoolStoriesDemo
//
//  Created by Ravi Rana on 30/06/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var homeFeedCollectionView: UICollectionView!
    var dataArray:[VideoModel]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        self.homeFeedCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.homeFeedCollectionView.contentInsetAdjustmentBehavior = .never
        
        setflowlayout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.check()
        }
    }
    
    fileprivate func setData() {
        dataArray = [VideoModel(username: "James", userProfilePicture: "userPic1", averageRating: 1.13, description: "dkljdajlk aklfadjkf aklfjadjfk kladfkajdf aklfjdalkf kljadklfjkadF KAFJKADf kaldfjakdj afklj", commentsCount: 33, koolsCount: 343, videoName: "video1"),
                     VideoModel(username: "Hendrics", userProfilePicture: "userPic2", averageRating: 4.4, description: "dkljdajlk  adfadf;lk adklfjadjk adklfjaldfafadjl kajfaklfadjkf aklfjadjfk kladfkajdf aklfjdalkf kljadklfjkadF KAFJKADf kaldfjakdj afklj", commentsCount: 334, koolsCount: 33, videoName: "video2"),
                     VideoModel(username: "Jimmy", userProfilePicture: "userPic3", averageRating: 5.3, description: "dkljdajlk  dkljlkadf kljakfad aklfadjkf aklfjadjfk kladfkajdf aklfjdalkf kljadklfjkadF KAFJKADf kaldfjakdj afklj", commentsCount: 63, koolsCount: 73, videoName: "video3"),
                     VideoModel(username: "Simran", userProfilePicture: "userPic4", averageRating: 8.13, description: "dkljdajlk  BBBBBB JKKGGG JKGKGJJKH JKGKGJaklfadjkf aklfjadjfk kladfkajdf aklfjdalkf kljadklfjkadF KAFJKADf kaldfjakdj afklj", commentsCount: 67, koolsCount: 444, videoName: "video4"),
                     VideoModel(username: "James GG", userProfilePicture: "userPic1", averageRating: 4.9, description: "dkljdajlk aklfadjkf aklfjadjfk kladfkajdf aklfjdalkf kljadklfjkadF KAFJKADf kaldfjakdj afklj", commentsCount: 32, koolsCount: 343, videoName: "video5"),
                     VideoModel(username: "Hendrics AASR", userProfilePicture: "userPic5", averageRating: 4.4, description: "dkljdajlk  adfadf;lk adklfjadjk adklfjaldfafadjl kajfaklfadjkf aklfjadjfk kladfkajdf aklfjdalkf kljadklfjkadF KAFJKADf kaldfjakdj afklj", commentsCount: 334, koolsCount: 33, videoName: "video1"),
                     VideoModel(username: "Jimmy BB", userProfilePicture: "userPic3", averageRating: 5.3, description: "dkljdajlk  dkljlkadf kljakfad aklfadjkf aklfjadjfk kladfkajdf aklfjdalkf kljadklfjkadF KAFJKADf kaldfjakdj afklj", commentsCount: 63, koolsCount: 73, videoName: "video2"),
                     VideoModel(username: "Simran ji", userProfilePicture: "userPic3", averageRating: 8.13, description: "dkljdajlk  BBBBBB JKKGGG JKGKGJJKH JKGKGJaklfadjkf aklfjadjfk kladfkajdf aklfjdalkf kljadklfjkadF KAFJKADf kaldfjakdj afklj", commentsCount: 67, koolsCount: 444, videoName: "video5"),
                     VideoModel(username: "Hendrics SR", userProfilePicture: "userPic5", averageRating: 4.4, description: "dkljdajlk  adfadf;lk adklfjadjk adklfjaldfafadjl kajfaklfadjkf aklfjadjfk kladfkajdf aklfjdalkf kljadklfjkadF KAFJKADf kaldfjakdj afklj", commentsCount: 334, koolsCount: 33, videoName: "video2"),
                     VideoModel(username: "Jimmy BBA", userProfilePicture: "userPic3", averageRating: 5.3, description: "dkljdajlk  dkljlkadf kljakfad aklfadjkf aklfjadjfk kladfkajdf aklfjdalkf kljadklfjkadF KAFJKADf kaldfjakdj afklj", commentsCount: 63, koolsCount: 73, videoName: "video4"),
                     VideoModel(username: "Simran ae", userProfilePicture: "userPic5", averageRating: 8.13, description: "dkljdajlk  BBBBBB JKKGGG JKGKGJJKH JKGKGJaklfadjkf aklfjadjfk kladfkajdf aklfjdalkf kljadklfjkadF KAFJKADf kaldfjakdj afklj", commentsCount: 67, koolsCount: 444, videoName: "video5")]
        
    }
    
    fileprivate func setflowlayout() {
        let flowLayout = UICollectionViewFlowLayout()
        
        let width = view.bounds.width
        var height: CGFloat = view.bounds.height
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            let topPadding = (window?.safeAreaInsets.top)!
            let bottomPadding = (window?.safeAreaInsets.bottom)!
            height = view.bounds.height - (topPadding + bottomPadding)
        }
        
        flowLayout.itemSize = CGSize(width: width, height:height)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        homeFeedCollectionView.collectionViewLayout = flowLayout
        homeFeedCollectionView.delegate = self
        homeFeedCollectionView.dataSource = self
        homeFeedCollectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeFeedCell", for: indexPath) as! HomeFeedCell
        if let model = dataArray?[indexPath.row] {
            cell.setupData(data: model)
            cell.commentActionCallback = {
                self.alertFor(action: "Comment action!")
            }
            
            cell.shareActionCallback = {
                self.alertFor(action: "Share action!")
            }
            
            cell.profileActionCallback = {
                self.alertFor(action: "Profile action!")
            }
            
            cell.collaboratorActionCallback = {
                self.alertFor(action: "Collaborator action!")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        return screenSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? HomeFeedCell)?.stopVideo()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { check() }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        check()
    }
    
    func check() {
        checkPlay()
    }
    
    func checkPlay() {
        let visibleCells = self.homeFeedCollectionView.visibleCells.compactMap { $0 as? HomeFeedCell }
        
        guard visibleCells.count > 0 else { return }
        
        let visibleFrame = CGRect(x: 0, y: self.homeFeedCollectionView.contentOffset.y, width: self.homeFeedCollectionView.bounds.width, height: self.homeFeedCollectionView.bounds.height)
        
        let visibleCell = visibleCells
            .filter { visibleFrame.intersection($0.frame).height >= $0.frame.height / 2 }
            .first
        visibleCell?.playVideo()
    }
    
    func alertFor(action:String) {
        let alert = UIAlertController(title: action, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}

