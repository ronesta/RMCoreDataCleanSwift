//
//  CharacterPresenterProtocol.swift
//  RMCoreDataCleanSwift
//
//  Created by Ибрагим Габибли on 14.02.2025.
//

import Foundation

protocol CharacterPresenterProtocol {
    func presentCharacters(response: CharacterModel.Response)
    func presentError(_ message: String)
}
