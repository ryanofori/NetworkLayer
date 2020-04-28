//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Ryan Ofori on 4/22/20.
//  Copyright © 2020 Ryan Ofori. All rights reserved.
//

import UIKit

class NetworkError {
    enum Status: String, Error {
        case paramsNil = "No params were passed"
        case invalidURL = "invalidURL"
        case noData = "No data"
    }
}
