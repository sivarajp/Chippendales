//
//  EmojiCell.swift
//  Chippendales
//
//  Created by Sivaraj-Pasumalaithevan (Contractor) on 6/16/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import UIKit

class EmojiCell: UICollectionViewCell {
  
  
  @IBOutlet weak var imageView: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override var bounds: CGRect {
    didSet {
      contentView.frame = bounds
    }
  }
  
//  override var isSelected: Bool {
//    willSet {
//      self.imageView?.backgroundColor = isSelected ? UIColor.black : UIColor.white
//    }
//  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
}
