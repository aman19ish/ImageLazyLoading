//
//  ImageListViewModel.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

class ImageListViewModel: NSObject {
    
    // MARK: - Properties
    lazy var apiRepository = ImageViewAPIRepository()
    private var model: ImageListModel?
    var currentPage = 0
    var searchString = ""
    var viewState: ViewState = .loaded
    
    // MARK: - Initilizer
    override init() {
        super.init()
    }
    
    // MARK: - API Call's
    func getImageList(params: [String: String], completion: ((_ success: Bool,
        _ error: String?) -> Void)?) {
        viewState = .loading
        apiRepository.getImageList(params: params) { [weak self] (responseImageListModel, errorString) in
            self?.viewState = .loaded
            if let errorString = errorString {
                completion?(false, errorString)
                return
            }
            
            if let imageList = responseImageListModel {
                if (imageList.imageDetailList?.count ?? 0) > 0, let searchString = self?.searchString {
                    UserDefaults.addSuccessfullSearchString(searchString: searchString)
                }
                if self?.currentPage == 1 {
                    self?.model = imageList
                }
                
                if let arrayImagesDetail = imageList.imageDetailList {
                    self?.model?.imageDetailList?.append(contentsOf: arrayImagesDetail)
                }
                completion?(true, nil)
                return
            } else {
                completion?(false, errorString)
                return
            }
        }
    }
    
    func fetchImagesList(searchString: String, completion: ((_ success: Bool,
    _ error: String?) -> Void)?) {
        if self.searchString != searchString {
            currentPage = 1
        }        
        self.searchString = searchString
        guard searchString.count < ImageListViewContant.maxSearchCharacterLimit else {
            completion?(false, CommonErrorContsants.searchStringIsToLong)
            return
        }
        
        var params = [APIKey.query: searchString.replacingOccurrences(of: " ", with: "+")]
        params[APIKey.perPage] = "\(ImageListViewContant.perPageCount)"
        params[APIKey.page] = "\(currentPage)"
        params[APIKey.pretty] = "true"
        getImageList(params: params, completion: completion)

    }
    
    func fetchNextPageContent(at indexPath: IndexPath, completion: ((_ success: Bool,
       _ error: String?) -> Void)?) {
        //If last cell is called then time for new images 
        if indexPath.row == (model?.imageDetailList?.count ?? 0) - 1 {
            currentPage += 1
            if ((model?.totalHits ?? 0) / ImageListViewContant.perPageCount) >= currentPage {
                fetchImagesList(searchString: searchString, completion: completion)
            }
        }
    }
    
}

// MARK: - Collection View Helper Methods
extension ImageListViewModel {
    func getNumberOfSection() -> Int {
        return 1
    }
    
    func getNumberOfRows() -> Int {
        return model?.imageDetailList?.count ?? 0
    }
    
    func getImageDetailModel(at indexPath: IndexPath) -> ImageDetailModel? {
        return model?.imageDetailList?[indexPath.row]
    }
    
    func getImageDetailListCount() -> Int {
        return model?.imageDetailList?.count ?? 0
    }
    
    func isImageDetailListOutOfRange(at indexPath: IndexPath) -> Bool {
        if indexPath.row > (model?.imageDetailList?.count ?? 0) - 1 {
            return true
        }
        return false
    }
    
}

// MARK: - Helper Methods
extension ImageListViewModel {
    func updateRquestDownloadedImageURLPriority(at indexPath: IndexPath) {
        let imageDetailModel = getImageDetailModel(at: indexPath)
        if let previewURL = imageDetailModel?.previewURL, let url = URL(string: previewURL) {
            ImageManager.shared.setLowPriority(url: url)
        }
    }
    
}
