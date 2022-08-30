//
//  LottoAPIManager.swift
//  SeSAC2Week9
//
//  Created by Seokjune Hong on 2022/08/30.
//

import Foundation

//shared - 단순함. 커스텀 X. 응답클로저. 백그라운드 X
//default configuration - shared 설정 유사. 커스텀O(셀룰러 연결 여부, 타임 아웃 간격) . 응답 클로저 + 딜리게이트

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

class LottoAPIManager {
    static func requestLotto(drwNo: Int, completion: @escaping (Lotto?, APIError?) -> Void ) {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
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
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    completion(result, nil)
                    print(result)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
            
        }.resume()
    }
}
