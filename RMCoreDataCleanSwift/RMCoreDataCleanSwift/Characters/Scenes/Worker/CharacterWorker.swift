//
//  CharacterWorker.swift
//  RMCoreDataCleanSwift
//
//  Created by Ибрагим Габибли on 14.02.2025.
//

import Foundation
import UIKit

final class CharacterWorker: CharacterWorkerProtocol {
    var networkManager: NetworkManagerProtocol
    var storageManager: StorageManagerProtocol

    init(networkManager: NetworkManagerProtocol,
         storageManager: StorageManagerProtocol
    ) {
        self.networkManager = networkManager
        self.storageManager = storageManager
    }

    func getCharacters(completion: @escaping ([Entity]) -> Void) {
        let savedCharacters = storageManager.fetchCharacters()

        guard savedCharacters.isEmpty else {
            completion(savedCharacters)
            return
        }

        networkManager.getCharacters { [weak self] result, error in
            guard let self else {
                return
            }

            if let error {
                print("Error getting characters: \(error)")
                return
            }

            guard let result else {
                print("No result returned.")
                return
            }

            var charactersToSave: [(character: Character, imageData: Data)] = []

            let group = DispatchGroup()

            result.forEach { res in
                group.enter()
                self.networkManager.loadImage(from: res.image) { data, error in
                    defer {
                        group.leave()
                    }

                    if let error {
                        print("Failed to load image: \(error)")
                        return
                    }

                    guard let data else {
                        print("No data for image")
                        return
                    }

                    charactersToSave.append((character: res, imageData: data))
                }
            }

            group.notify(queue: .main) { [weak self] in
                guard let self else {
                    return
                }
                self.storageManager.saveCharacters(charactersToSave)

                DispatchQueue.main.async {
                    let savedCharacters = self.storageManager.fetchCharacters()
                    completion(savedCharacters)
                }
            }
        }
    }

    func getImageData(forCharacterId characterId: Int64) -> Data? {
        return storageManager.fetchImageData(forCharacterId: characterId)
    }
}
