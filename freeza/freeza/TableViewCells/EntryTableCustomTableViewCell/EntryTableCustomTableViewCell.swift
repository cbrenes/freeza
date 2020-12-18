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
    
    var entry: EntryViewModel? {
        didSet {
            self.configureForEntry()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureViews()
    }
    
    @IBAction func favoriteIconWasTouched(_ sender: Any) {
        print("👾 favoriteIconWasTouched")
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
    
    private func configureForEntry() {
        guard let entry = self.entry else {
            return
        }
        self.thumbnailImageView.image = entry.thumbnail
        self.authorLabel.text = entry.author
        self.commentsCountLabel.text = entry.commentsCount
        self.ageLabel.text = entry.age
        self.entryTitleLabel.text = entry.title
        entry.loadThumbnail { [weak self] in
            self?.thumbnailImageView.image = entry.thumbnail
        }
    }
}

extension UIImage {

func blur(_ radius: Double) -> UIImage? {
    if let img = CIImage(image: self) {
        return UIImage(ciImage: img.applyingGaussianBlur(sigma: radius))
    }
    return nil
}
}
