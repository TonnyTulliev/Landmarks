//
//  MainModel.swift
//  LandMarks
//
//  Created by Антон Скуратов on 16.12.2021.
//

import Foundation
import UIKit

// MARK: - Landmark
struct Landmark: Codable {
    let name: String
    let category: Category
    let city, state: String
    let id: Int
    let park: String
    let coordinates: Coordinates
    let imageName: String
    let isFavorite: Bool
}

enum Category: String, Codable {
    case featured = "Featured"
    case lakes = "Lakes"
    case rivers = "Rivers"
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let longitude, latitude: Double
}


