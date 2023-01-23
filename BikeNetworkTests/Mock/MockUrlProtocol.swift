//
//  MockUrlProtocol.swift
//  BikeNetworkTests
//
//  Created by Yash Udhlani on 12/08/22.
//

import Foundation

class MockUrlProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = MockUrlProtocol.requestHandler else {
            fatalError("Handler is unavailable.")
          }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data = data {
              // 4. Send received data to the client.
              client?.urlProtocol(self, didLoad: data)
            }

            self.client?.urlProtocolDidFinishLoading(self)
        } catch {
        }
    }

    override func stopLoading() {

    }
}
