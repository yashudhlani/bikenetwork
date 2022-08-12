//
//  MockUrlProtocol.swift
//  BikeNetworkTests
//
//  Created by Yash Udhlani on 12/08/22.
//

import Foundation

class MockUrlProtocol: URLProtocol {
    static var mockData: Data?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        self.client?.urlProtocol(self, didLoad: MockUrlProtocol.mockData!)
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
