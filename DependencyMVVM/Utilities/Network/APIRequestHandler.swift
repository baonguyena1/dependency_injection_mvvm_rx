//
//  APIRequestHandler.swift
//  PeopleRoulette
//
//  Created by Bao Nguyen on 8/30/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol APIInjector {
    var apiHandler: APIRequestHandler! { get set }
}

class APIRequestHandler {
    private var manager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "jsonplaceholder.typicode.com": .disableEvaluation
        ]
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        return manager
    }()
    
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    func sendRequest<T: Decodable>(_ request: APIRequest) -> Single<T> {
        return Single<T>.create(subscribe: { [weak self] (single) -> Disposable in
            guard let `self` = self else { return Disposables.create() }
            
            let request = self.manager.request(request.url, method: request.method, parameters: request.parameters, encoding: request.encoding, headers: request.headers)
                .validate()
                .responseDecodable(decoder: self.decoder) { (response: DataResponse<T>) in
                    switch response.result {
                    case .success(let result):
                        single(.success(result))
                    case .failure(let error):
                        single(.error(error))
                    }
                }
            return Disposables.create { request.cancel() }
        })
    }
    
    func sendRequestResponseArray<T: Decodable>(_ request: APIRequest) -> Single<[T]> {
        return Single<[T]>.create(subscribe: { [weak self] (single) -> Disposable in
            guard let `self` = self else { return Disposables.create() }
            
            let request = self.manager.request(request.url,
                                               method: request.method,
                                               parameters: request.parameters,
                                               encoding: request.encoding,
                                               headers: request.headers)
                .validate()
                .responseDecodable(decoder: self.decoder) { (response: DataResponse<[T]>) in
                    switch response.result {
                    case .success(let result):
                        single(.success(result))
                    case .failure(let error):
                        single(.error(error))
                    }
            }
            return Disposables.create { request.cancel() }
        })
    }
}
