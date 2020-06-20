//
//  ImageViewListModel.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

// MARK: - Empty
struct ImageListModel: Codable {
    let total, totalHits: Int?
    let imageDetailList: [ImageDetailModel]?
    
    enum CodingKeys: String, CodingKey {
        case total, totalHits
        case imageDetailList = "hits"
    }
}

// MARK: - ImageViewModel
struct ImageDetailModel: Codable {
    let id: Int?
    let pageURL: String?
    let type, tags: String?
    let previewURL: String?
    let previewWidth, previewHeight: Int?
    let webformatURL: String?
    let webformatWidth, webformatHeight: Int?
    let largeImageURL: String?
    let imageWidth, imageHeight, imageSize, views: Int?
    let downloads, favorites, likes, comments: Int?
    let userID: Int?
    let user: String?
    let userImageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, favorites, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
}
