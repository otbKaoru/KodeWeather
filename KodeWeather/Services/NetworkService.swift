//
//  NetworkService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import Alamofire

enum NetworkError: Error {
    case networkError

    var errorText: String {
        switch self {
        case .networkError:
            return "Sorry, Network Error"
        }
    }
}

protocol NetworkServiceProtocol {
    func getJSONData(URL: URL, parameters: [String: Any], completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {

    func getJSONData(URL: URL, parameters: [String: Any], completion: @escaping (Result<Data, NetworkError>) -> Void) {
        AF.request(URL, parameters: parameters).responseJSON { responseJSON in
            switch responseJSON.result {
                case .success:
                    if let data = responseJSON.data {
                        completion(.success(data))
                    } else {
                        completion(.failure(NetworkError.networkError))
                    }
                case .failure:
                    completion(.failure(NetworkError.networkError))
            }
        }

    }
}
