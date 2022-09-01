//
//  Observable.swift
//  SeSAC2Week9
//
//  Created by Seokjune Hong on 2022/08/31.
//

import Foundation

class Observable<T> { // 양방향 바인딩
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didset", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        closure(value)
        listener = closure
    }
}
