//
//  RequestObservable.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 16.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation
import RxSwift

public class RxRequest {
    private var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession
    public init(config:URLSessionConfiguration) {
        urlSession = URLSession(configuration:
            URLSessionConfiguration.default)
    }
    
    public func getData<PostModel: Codable>(request: URLRequest)
        -> Observable<PostModel> {
            return Observable.create { observer in
                let task = self.urlSession.dataTask(with: request) { (data,
                    response, error) in
                    if let httpResponse = response as? HTTPURLResponse{
                        let statusCode = httpResponse.statusCode
                        do {
                            let dataToTransform = data ?? Data()
                            let json1 = try JSONSerialization.jsonObject(with: dataToTransform, options: .allowFragments)
                            let json = try JSONSerialization.jsonObject(with: dataToTransform, options: []) as? [String : Any]

                            if statusCode == 200 {
                                let objs = try self.jsonDecoder.decode(PostModel.self, from:
                                    dataToTransform)
                                observer.onNext(objs)
                            }
                            else {
                                observer.onError(error!)
                            }
                        } catch {
                            observer.onError(error)
                        }
                    }
                    observer.onCompleted()
                }
                task.resume()
                return Disposables.create {
                    task.cancel()
                }
            }
    }
}
