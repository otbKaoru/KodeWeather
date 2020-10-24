//
//  NetworkService.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

import Alamofire
import Foundation

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
    func fetchDecodableData<T: Decodable>(API: String, parametres: [String: Any], completion: @escaping (Result<T?, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {

    func fetchDecodableData<T: Decodable>(API: String, parametres: [String: Any] = [:], completion: @escaping (Result<T?, NetworkError>) -> Void) {
        guard let url = URL(string: API) else { return }
        getJSONData(URL: url, parameters: parametres) { result  in
            switch result {
            case .success(let data):
                let summary = try? JSONDecoder().decode(T.self, from: data)
                completion(.success(summary))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func getJSONData(URL: URL, parameters: [String: Any], completion: @escaping (Result<Data, NetworkError>) -> Void) {
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
