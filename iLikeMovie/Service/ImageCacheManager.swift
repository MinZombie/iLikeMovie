//
//  ImageCacheManager.swift
//  iLikeMovie
//
//  Created by 민선기 on 2022/05/06.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
