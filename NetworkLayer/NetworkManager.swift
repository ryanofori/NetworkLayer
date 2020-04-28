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
    
    private var urlTask: URLSessionTask?
    
    func networkURL(url: String, appendingPath: [String] = [])throws -> URL{
        guard var url = URL(string: url) else { throw
            NetworkError.Status.invalidURL
             }
        for path in appendingPath {
            url.appendPathComponent(path)
        }
        return url
    }
    
    func urlRequest(url: URL, httpMethod: String) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        //request.setValue(bodyValue, forHTTPHeaderField: headerField)
        return request
    }
    
    //3 methods max
    //param [String: String]
    func requestMethod(request: URLRequest, setValue: [String:String], completion: @escaping(Data?, URLResponse? ,Error?) -> Void) {
        //let param: String = param
        //let data = param.data(using: .utf8)
        //have functions that figure it out and throws errors
        //request.httpBody = data
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
    
    //depedancy injection and mocks
    func downTask(url: URL) {
        let downloadTask = URLSession.shared.downloadTask(with: url) { (url, response, error) in
            if let url = url {
                if let string = try? String(contentsOf: url) {
                    //completion handler
                    print(string)
                }
            }
        }
        downloadTask.resume()
    }
    
    func uploadTask(request: URLRequest, bodyData: Data) {
        let uploadTask = URLSession.shared.uploadTask(with: request, from: bodyData)
        //completion handler
        uploadTask.resume()
    }
    
    func cancel(){
        self.urlTask?.cancel()
    }
    
    func suspend() {
        self.urlTask?.suspend()
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
