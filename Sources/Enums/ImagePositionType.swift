//
//  ImagePositionType.swift
//  IBAnimatable
//
//  Created by ios dev on 2018/7/27.
//  Copyright © 2018年 IBAnimatable. All rights reserved.
//

import Foundation

public enum ImagePositionType: String, IBEnum {
  case top
  case right
  case bottom
  case left
}

#if swift(>=4.2)
extension ImagePositionType: CaseIterable {}
#endif
