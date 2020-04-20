//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Ryan Ofori on 4/18/20.
//  Copyright © 2020 Ryan Ofori. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func requestMethod(urlString: String, param: String = "", httpMethod: String = "GET", bodyValue:String = "", headerField: String = "", completion: @escaping(Data?, URLResponse? ,Error?) -> Void) {
        let param: String = param
        let data = param.data(using: .utf8)
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpBody = data
        if httpMethod == "POST" {
            request.setValue(bodyValue, forHTTPHeaderField: headerField)
        }
        request.httpMethod = httpMethod
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else { return }
            completion(data, nil, nil)
            if let response = response {
                NSLog(response.description)
                completion(nil, response, nil)
            }
            if let error = error {
                completion(nil, nil, error)
            }
        }
        task.resume()
    }
    
    
    
}
