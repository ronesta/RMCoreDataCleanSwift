//
//  CharacterModel.swift
//  RMCoreDataCleanSwift
//
//  Created by Ибрагим Габибли on 14.02.2025.
//

import Foundation

enum CharacterModel {
    struct Request {
    }

    struct Response {
        let characters: [Entity]
    }

    struct ViewModel {
        let characters: [Entity]
    }
}
