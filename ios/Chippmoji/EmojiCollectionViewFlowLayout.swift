//
//  File.swift
//  Chippendales
//
//  Created by Sivaraj-Pasumalaithevan (Contractor) on 8/8/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import UIKit

class EmojiCollectionViewFlowLayout: UICollectionViewFlowLayout {

func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
  var offsetAdjustment = CGFloat.greatestFiniteMagnitude
  let horizontalOffset = proposedContentOffset.x
  let targetRect = CGRect(origin: CGPoint(x: proposedContentOffset.x, y: 0), size: self.collectionView!.bounds.size)
  
  for layoutAttributes in super.layoutAttributesForElements(in: targetRect)! {
    let itemOffset = layoutAttributes.frame.origin.x
    if (abs(itemOffset - horizontalOffset) < abs(offsetAdjustment)) {
      offsetAdjustment = itemOffset - horizontalOffset
    }
  }
  
  return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
}
}
