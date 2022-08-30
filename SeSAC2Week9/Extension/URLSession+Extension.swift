//
//  URLSession+Extension.swift
//  SeSAC2Week9
//
//  Created by Seokjune Hong on 2022/08/30.
//

import Foundation

extension URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func customDataTask(_ endPoint: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        let task = dataTask(with: endPoint, completionHandler: completionHandler)
        task.resume()
        
        return task
    }
    
    static func request<T: Codable>(_ session: URLSession = .shared, endPoint: URLRequest, completion: @escaping (T?, APIError?) -> Void ) {
        session.customDataTask(endPoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print(("No Data Returned"))
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result, nil)
                    print(result)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }
    }
}
