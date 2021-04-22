//
//  BreedsListResponse.swift
//  Randog
//
//  Created by Ion Ceban on 4/22/21.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
