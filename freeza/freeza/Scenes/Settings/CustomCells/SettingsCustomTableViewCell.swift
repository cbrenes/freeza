//
//  SettingsCustomTableViewCell.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import UIKit

protocol SettingsCustomTableViewCellDelegate: class {
    func setValue(indexPath: IndexPath, value: Bool)
}

class SettingsCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var switchOutlet: UISwitch!
    weak var delegate: SettingsCustomTableViewCellDelegate?
    
    private var indexPath = IndexPath(item: 0, section: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setupCell(item: Settings.ItemToDisplay, indexPath: IndexPath) {
        leftLabel.text = item.title
        self.indexPath = indexPath
        switchOutlet.isOn = item.value
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        delegate?.setValue(indexPath: indexPath, value: sender.isOn)
    }
}
