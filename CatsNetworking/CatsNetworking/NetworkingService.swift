//
//  NetworkingService.swift
//  CatsNetworking
//
//  Created by Zakhar Litvinchuk on 19.05.2024.
//

import Foundation
import FirebaseCore
import FirebasePerformance

public final class CatsNetworkingService {
    
    public init(){
        FirebaseApp.configure()
    }
    
    private func createCatsUrl(animal: Animal, limit: Int) -> URL? {
        guard let startPath = URL(string: "https://api.the\(animal.rawValue)api.com/v1/images/search")
        else { return nil }
        return startPath.appending(queryItems: [URLQueryItem(name: "limit", value: "\(limit)")])
    }
    
    public func getCatsImages(animal: Animal, limit: Int) async throws -> [AnimalImage] {
        guard let reqURL = createCatsUrl(animal: animal, limit: limit) else {
            throw NetworkingErrors.invalidURL
        }
        let trace = Performance.startTrace(name: "CATS_LIST_DOWNLOADING_TIME")
        let (data, response) = try await URLSession.shared.data(from: reqURL)
        if let response = response as? HTTPURLResponse {
            trace?.stop()
            if response.statusCode != 200 {
                throw NetworkingErrors.invalidResponse
            }
        }
        let catImages = try JSONDecoder().decode([AnimalImage].self, from: data)
        return catImages
    }
    
}

public enum NetworkingErrors : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

public enum Animal: String {
    case cat = "cat"
    case dog = "dog"
}

