//
//  HomeWorker.swift
//  TestLBC
//
//  Created by Jordane HUY on 22/06/2022.
//

import Foundation

class HomeWorker {
    func getListing(completion: @escaping ([Item]?, Error?) -> Void) {
        request(endpoint: .getListing, completion: { data, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            do {
                let items = try decoder.decode([Item].self, from: data)
                completion(items, nil)
            } catch {
                debugPrint("error in parsing : \(error)")
                completion(nil, error)
                return
            }
        })
    }
    
    func request(endpoint: HomeEndpoint, completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession.shared

        // URL
        let url = URL(string: endpoint.baseURLString + endpoint.path)!
        var urlRequest = URLRequest(url: url)

        // HTTP Method
        urlRequest.httpMethod = endpoint.httpMethod.rawValue

        // HTTP Headers
        endpoint.headers?.forEach({ header in
            urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
        })

        let task = session.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(nil, error)
                    return
                }
                    
                completion(data, error)
            }
        }

        task.resume()
    }
}
