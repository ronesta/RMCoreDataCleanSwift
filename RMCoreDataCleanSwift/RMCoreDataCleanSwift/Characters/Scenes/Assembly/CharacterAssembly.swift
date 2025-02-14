//
//  CharacterAssembly.swift
//  RMCoreDataCleanSwift
//
//  Created by Ибрагим Габибли on 14.02.2025.
//

import Foundation
import UIKit

final class CharacterAssembly {
    static func build() -> UIViewController {
        let storageManager = CoreDataManager()
        let networkManager = NetworkManager()

        let viewController = CharacterViewController()
        let presenter = CharacterPresenter()
        let worker = CharacterWorker(networkManager: networkManager,
                                     storageManager: storageManager
        )
        let interactor = CharactersInteractor(presenter: presenter,
                                              worker: worker
        )

        viewController.interactor = interactor
        viewController.storageManager = storageManager
        presenter.viewController = viewController

        return viewController
    }
}
