//
//  ListViewCell.swift
//  Numbers
//
//  Created by Andrew McLean on 5/11/22.
//

import UIKit

class ListViewCell: UITableViewCell {
    static let cellID : String = "ListViewCell"
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: true)
        selectedBackgroundView?.backgroundColor = .green
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedBackgroundView?.backgroundColor = .red
    }
}
