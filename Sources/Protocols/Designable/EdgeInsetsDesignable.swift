//
//  EdgeInsetsDesignable.swift
//  IBAnimatable
//
//  Created by ios dev on 2018/7/27.
//  Copyright © 2018年 IBAnimatable. All rights reserved.
//

import UIKit

public protocol EdgeInsetsDesignable: class {
  /**
   `ImagePositionType: top, right, bottom, left, if not specified, left will be used
   */
  var imagePositionType: ImagePositionType { get set }
  
  /**
   `spacing`, spacing
   */
  var spacing: CGFloat { get set }
}

// MARK: - UIButton

public extension EdgeInsetsDesignable where Self: UIButton {
  public func configureEdgeInsets() {
    configureEdgeInsets(in: self)
  }
  
  func configureEdgeInsets(in view: UIView) {
    guard self.titleLabel?.text != nil else {
      return
    }
    
    guard self.imageView?.image != nil else {
      return
    }
    
    guard !self.spacing.isNaN && self.spacing > 0 else {
      return
    }
    
    let imageSize = self.imageView!.image!.size
    
    let imageWidth = imageSize.width
    let imageHeight = imageSize.height

    let labelSize = self.titleLabel!.bounds.size
    
    let labelWidth = labelSize.width
    let labelHeight = labelSize.height

    let imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2
    let imageOffsetY = imageHeight / 2 + spacing / 2
    let labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2
    let labelOffsetY = labelHeight / 2 + spacing / 2
    
    let tempWidth = max(labelWidth, imageWidth)
    let changedWidth = labelWidth + imageWidth - tempWidth
    let tempHeight = max(labelHeight, imageHeight)
    let changedHeight = labelHeight + imageHeight + spacing - tempHeight
    
    switch imagePositionType {
    case .left:
      self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2)
      self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2)
      self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2)
    case .right:
      self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2))
      self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2)
      self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2)
    case .top:
      self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX)
      self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX)
      self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2)
    case .bottom:
      self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX)
      self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX)
      self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2)
    }
  }
}
