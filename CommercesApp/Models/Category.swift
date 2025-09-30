//
//  Category.swift
//  CommercesApp
//
//  Created by Jose Maria Mata Ojeda on 24/9/25.
//

import Foundation
import UIKit

enum Category: String, Codable {
    case beauty = "BEAUTY"
    case directSales = "DIRECT_SALES"
    case electricStation = "ELECTRIC_STATION"
    case food = "FOOD"
    case gasStation = "GAS_STATION"
    case leisure = "LEISURE"
    case shopping = "SHOPPING"
    
    func name() -> String {
        switch self {
        case .beauty:
            return "Belleza"
        case .directSales:
            return "Venta directa"
        case .electricStation:
            return "Recarga electrica"
        case .food:
            return "Alimentación"
        case .gasStation:
            return "Gasolineras"
        case .leisure:
            return "Ocio"
        case .shopping:
            return "Compras"
        }
    }
    
    func whiteIcon() -> String {
        switch self {
        case .food:
            return "Catering_white"
        case .shopping:
            return "Cart_white"
        case .beauty:
            return "Car_wash_white"
        case .leisure:
            return "Leisure_white"
        case .directSales:
            return "Payment_Regulated_Parking_white"
        case .electricStation:
            return "Electric_Scooter_white"
        case .gasStation:
            return "EES_white"
        }
    }
    
    func colorIcon() -> String {
        switch self {
        case .food:
            return "Catering_colour"
        case .shopping:
            return "Cart_colour"
        case .beauty:
            return "Car_wash_colour"
        case .leisure:
            return "Leisure_colour"
        case .directSales:
            return "Payment_Regulated_Parking_colour"
        case .electricStation:
            return "Electric_Scooter_colour"
        case .gasStation:
            return "EES_colour"
        }
    }
    
    func color() -> UIColor {
        switch self {
        case .beauty:
            return .systemGreen
        case .directSales:
            return .systemTeal
        case .electricStation:
            return .systemRed
        case .food:
            return .systemYellow
        case .gasStation:
            return .systemOrange
        case .leisure:
            return .systemPurple
        case .shopping:
            return .systemPink
        }
    }
}
