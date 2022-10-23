//
//  NewsCategory.swift
//  NewsApp
//
//  Created by Андрей Парчуков on 24.10.2022.
//

import Foundation

enum NewsCategory: String, CaseIterable {
    
    case business
    case sport
    case world
    case politics
    case technology
    case science
    case automobile
    
    var symbol: String {
        switch self {
        case .business: return "bag.fill"
        case .sport:  return "bicycle"
        case .world: return "globe.europe.africa.fill"
        case .politics: return "person.2.fill"
        case .technology: return "cpu.fill"
        case .science: return "atom"
        case .automobile: return "car.fill"
        }
    }
    
}
