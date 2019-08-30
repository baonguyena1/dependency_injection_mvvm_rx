//
//  APIRequest.swift
//  PeopleRoulette
//
//  Created by Bao Nguyen on 8/30/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import Alamofire

struct APIRequest {
    let url: String
    let method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders?
    let encoding: ParameterEncoding
    
    init(url: String,
         method: HTTPMethod,
         parameters: Parameters? = nil,
         headers: HTTPHeaders? = nil,
         encoding: ParameterEncoding = JSONEncoding.default) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.encoding = encoding
    }
    
    init(endpoint: EndPoint,
         parameters: Parameters? = nil,
         encoding: ParameterEncoding = JSONEncoding.default) {
        self.url = endpoint.url
        self.method = endpoint.method
        self.parameters = parameters
        self.headers = endpoint.headers
        self.encoding = encoding
    }
}
