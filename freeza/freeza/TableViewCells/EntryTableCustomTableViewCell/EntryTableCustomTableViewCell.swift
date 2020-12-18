//
//  EntryTableCustomTableViewCell.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import UIKit

class EntryTableCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var entryTitleLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var thumbnailImageContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    var indexPath = IndexPath(row: 0, section: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureViews()
    }
    
    private func configureViews() {
        func configureThumbnailImageView() {
            self.thumbnailImageContainerView.layer.borderColor = UIColor.black.cgColor
            self.thumbnailImageContainerView.layer.borderWidth = 1
        }
        
        func configureCommentsCountLabel() {
            self.commentsCountLabel.layer.cornerRadius = self.commentsCountLabel.bounds.size.height / 2
        }
        configureThumbnailImageView()
        configureCommentsCountLabel()
    }
    
    //    private func configureForEntry() {
    //        guard let entry = self.entry else {
    //            return
    //        }
    //        self.thumbnailImageView.image = entry.thumbnail
    //        self.authorLabel.text = entry.author
    //        self.commentsCountLabel.text = entry.commentsCount
    //        self.ageLabel.text = entry.age
    //        self.entryTitleLabel.text = entry.title
    //        entry.loadThumbnail { [weak self] in
    //            self?.thumbnailImageView.image = entry.thumbnail
    //        }
    //    }
    
    func setupCell(item: MainEntry.ItemToDisplay, indexPath: IndexPath) {
        authorLabel.text = item.author
        commentsCountLabel.text = item.commentCount
        ageLabel.text = item.time
        entryTitleLabel.text = item.title
        favoriteImageView.image = item.heartImage
        self.indexPath = indexPath
        loadThumbnail(thumbnailURL: item.thumbnailImageURL) { [weak self](image) in
            if item.shouldHideContent {
                self?.thumbnailImageView.image = image.blur(10)
            } else {
                self?.thumbnailImageView.image = image
            }
        }
    }
    
    @IBAction func favoriteIconWasTouched(_ sender: Any) {
        print("👾 favoriteIconWasTouched")
    }
    
    func loadThumbnail(thumbnailURL: URL?, withCompletion completion: @escaping (_ image: UIImage) -> ()) {
        
        guard let thumbnailURL = thumbnailURL else {
            
            return
        }
        let downloadThumbnailTask = URLSession.shared.downloadTask(with: thumbnailURL) {(url, urlResponse, error) in
            guard let url = url,
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        downloadThumbnailTask.resume()
    }
}

