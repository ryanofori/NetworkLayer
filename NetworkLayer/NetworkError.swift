//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Ryan Ofori on 4/22/20.
//  Copyright © 2020 Ryan Ofori. All rights reserved.
//

import UIKit

class NetworkError: Error {
    enum staus {
        case invalidURL
        case noData
    }
}
