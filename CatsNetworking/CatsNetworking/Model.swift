//
//  Model.swift
//  CatsNetworking
//
//  Created by Zakhar Litvinchuk on 19.05.2024.
//

import Foundation

public struct AnimalImage: Codable, Hashable {
    public let id: String
    public let link: URL
    public let width: Int
    public let height: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case link = "url"
        case width
        case height
    }
}
