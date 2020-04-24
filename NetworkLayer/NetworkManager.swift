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
    
    func networkURL(url: String) {
        guard let url = URL(string: url) else { NetworkError.staus.invalidURL
            return }
    }
    
    
    //3 methods max
    //param [String: String]
    func requestMethod(url: String, param: String = "", httpMethod: String = "GET", bodyValue:String = "", headerField: String = "", completion: @escaping(Data?, URLResponse? ,Error?) -> Void) {
        let param: String = param
        let data = param.data(using: .utf8)
        guard let url = URL(string: url) else { NetworkError.staus.invalidURL
            return }
        var request = URLRequest(url: url)
        request.httpBody = data
        if httpMethod == "POST" {
            request.setValue(bodyValue, forHTTPHeaderField: headerField)
        }
        request.httpMethod = httpMethod
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
    
    func dataTask(request: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
    
    func downTask(urlString: String) {
        guard let url = URL(string: urlString) else { NetworkError.staus.invalidURL
            return
        }
        let downloadTask = URLSession.shared.downloadTask(with: url) { (url, response, error) in
            if let localURL = url {
                if let string = try? String(contentsOf: localURL) {
                    print(string)
                }
            }
        }

        downloadTask.resume()
    }
    
    func uploadTask(request: URLRequest, bodyData: Data) {
        let uploadTask = URLSession.shared.uploadTask(with: request, from: bodyData)
        uploadTask.resume()
    }
    
//    func uploadTask(request: URLRequest, completion: @escaping(Data?, URLResponse? ,Error?) -> Void) {
//
//        let uploadTask = URLSession.shared.downloadTask(with: request) { data, response, error in
//            completion(data, response, error)
//        }
//        uploadTask.resume()
//    }
    
    func getData(urlString: String, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else { return }
            completion(data)
            //            if let response = response {
            //                NSLog(response.description)
            //            }
            if let error = error {
                NSLog(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func postData(urlString: String, param: String, completion: @escaping([String: Any]) -> Void) {
        let param: String = param
        let data = param.data(using: .utf8)
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error  in
            if let response = response {
                NSLog(response.description)
            }
            if let error = error {
                NSLog(error.localizedDescription)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    completion(json ?? ["": (Any).self])
                } catch {
                    NSLog(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
}
