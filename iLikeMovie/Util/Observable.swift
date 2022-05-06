//
//  Observable.swift
//  iLikeMovie
//
//  Created by 민선기 on 2022/05/06.
//

import Foundation

final class Observable<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
