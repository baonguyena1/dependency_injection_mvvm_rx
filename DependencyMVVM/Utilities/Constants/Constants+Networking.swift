//
//  Constants+Networking.swift
//  DependencyMVVM
//
//  Created by Bao Nguyen on 8/30/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//
import Alamofire

struct URL {
    static var baseURL: String { return "https://jsonplaceholder.typicode.com" }
}

public enum EndPoint {
    case users
    case userProfile(String)
}

extension EndPoint {
    public var baseURL: String { return URL.baseURL }
    public var path: String {
        switch self {
        case .users:
            return "/users"
        case .userProfile(let id):
            return "/users/\(id)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .users, .userProfile:
            return HTTPMethod.get
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
        case .users, .userProfile:
            return nil
        }
    }
    
    public var url: String { return baseURL.appending(path) }
}
