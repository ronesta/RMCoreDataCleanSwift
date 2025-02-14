//
//  CharacterViewProtocol.swift
//  RMCoreDataCleanSwift
//
//  Created by Ибрагим Габибли on 14.02.2025.
//

import Foundation

protocol CharacterViewProtocol: AnyObject {
    func displayCharacters(viewModel: CharacterModel.ViewModel)
    func displayError(_ message: String)
}
