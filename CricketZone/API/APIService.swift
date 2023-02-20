//
//  APIService.swift
//  CricketZone
//
//  Created by BJIT on 2/10/23.
//

import Foundation

final class APIService {
    
    enum ServiceError: Error {
        case noDataError
        case jsonDecodingError
        
        var localizedDescription: String {
            switch self {
            case .noDataError:
                return NSLocalizedString("No data found", comment: "")
            case .jsonDecodingError:
                return NSLocalizedString("JSON decoding failed", comment: "")
            }
        }
    }
    
    class func fetchData<T: Codable> (
        from url: URL,
        using parameters: [String:String] = [:],
        completion: @escaping (Result<T, Error>) -> ()) {
            
//            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
//            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
//            guard let updatedURL = components.url else { return}
//
//            print(updatedURL)

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(ServiceError.noDataError))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(ServiceError.jsonDecodingError))
                }
            }.resume()
    }
    
}
