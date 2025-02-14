//
//  CharacterInteractorProtocol.swift
//  RMCoreDataCleanSwift
//
//  Created by Ибрагим Габибли on 14.02.2025.
//

import Foundation
import UIKit

protocol CharacterInteractorProtocol {
    func getCharacters(request: CharacterModel.Request)
    func getCharacterImage(for characterId: Int64, completion: @escaping (Data?) -> Void)
}
