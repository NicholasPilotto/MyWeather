//
//  Service.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 03/11/22.
//

import Foundation

public enum ServiceError: Error {
    case invalidURL
    case unknown
    case badStatusCode
    case badJSONParsing
}

class Service {
    public static let shared = Service()
    
    private init() {}
    
    public func fetch(url: URL?, completion: @escaping (Result<WeatherModel, ServiceError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.unknown))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(.badStatusCode))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(WeatherModel.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(.badJSONParsing))
            }
        }.resume()
    }
}
