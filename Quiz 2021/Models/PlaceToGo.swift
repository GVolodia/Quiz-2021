//
//  AnymalType.swift
//  Quiz 2021
//
//  Created by noone on 12/6/21.
//

enum PlaceToGo: String {
    case greenland = "greenland.jpeg"
    case tahiti = "tahiti.jpeg"
    case karelia = "karelia.jpeg"
    case australia = "australia.jpeg"
    case city = "club.jpeg"
    
    var definition: String {
        switch self {
        case .greenland:
            return "Гренландия. Самый большой остров Земли!"
        case .tahiti:
            return "Таити. Это рай на земле!"
        case .karelia:
            return "Карелия. Край первозданной природы и красивых пейзажей!"
        case .australia:
            return "Австралия. Страна и континент!"
        case .city:
            return "Клуб. Десять минут на такси — и вы в отпуске!"
        }
    }
}
