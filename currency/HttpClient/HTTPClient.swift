//
//  File.swift
//  Currency
//
//  Created by 小牛 on 2020/08/29.
//  Copyright © 2020 小牛. All rights reserved.
//

import Foundation

protocol EasyRequestDelegate: class {
    func onError()
}

public struct EasyRequest<Model: Codable> {
    
    public typealias SuccessCompletionHandler = (_ response: Model) -> Void
    
    static func get(_ delegate: EasyRequestDelegate?,
                     url: String,
                    success successCallback: @escaping SuccessCompletionHandler
    ) {
        
      //We need to be sure that we have an usable url to make the request,
      //if not lets call the delegate to manage the error
        guard let urlComponent = URLComponents(string: url), let usableUrl = urlComponent.url else {
            delegate?.onError()
            return
        }

        var request = URLRequest(url: usableUrl)
        request.httpMethod = "GET"
        
        var dataTask: URLSessionDataTask?
        let defaultSession = URLSession(configuration: .default)
        
        dataTask =
            defaultSession.dataTask(with: request) { data, response, error in
                defer {
                    dataTask = nil
                }
                if error != nil {
                    delegate?.onError()
                } else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    guard let model = self.parsedModel(with: data) else {
                        delegate?.onError()
                        return
                    }
                    successCallback(model)
                }
        }
        dataTask?.resume()

    }
    
    static func parsedModel(with data: Data) -> Model? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model =  try decoder.decode(Model.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}
