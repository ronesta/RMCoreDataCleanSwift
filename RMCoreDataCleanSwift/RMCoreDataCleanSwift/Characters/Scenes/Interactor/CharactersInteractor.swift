//
//  CharactersInteractor.swift
//  RMCoreDataCleanSwift
//
//  Created by Ибрагим Габибли on 14.02.2025.
//

import Foundation
import UIKit

final class CharactersInteractor: CharacterInteractorProtocol {
    var presenter: CharacterPresenterProtocol
    var worker: CharacterWorkerProtocol

    init(presenter: CharacterPresenterProtocol,
         worker: CharacterWorkerProtocol
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    func getCharacters(request: CharacterModel.Request) {
        worker.getCharacters { [weak self] characters in
            let response = CharacterModel.Response(characters: characters)

            self?.presenter.presentCharacters(response: response)
        }
    }

    func getCharacterImage(for characterId: Int64, completion: @escaping (Data?) -> Void) {
        let data = worker.getImageData(forCharacterId: characterId)
        completion(data)
    }
}
