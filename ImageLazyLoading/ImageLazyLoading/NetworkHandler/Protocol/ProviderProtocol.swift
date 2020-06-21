//
//  ProviderProtocol.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import Foundation

protocol ProviderProtocol {
    func request<T>(type: T.Type,
                    service: ServiceProtocol,
                    success: @escaping (T) -> (),
                    failure: @escaping (Error?) -> ()) where T: Codable
}
