//
//  CharacterWorkerProtocol.swift
//  RMCoreDataCleanSwift
//
//  Created by Ибрагим Габибли on 14.02.2025.
//

import Foundation
import UIKit

protocol CharacterWorkerProtocol {
    func getCharacters(completion: @escaping ([Entity]) -> Void)
}
