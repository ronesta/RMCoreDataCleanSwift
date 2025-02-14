//
//  NetworkManagerProtocol.swift
//  RMCoreDataCleanSwift
//
//  Created by Ибрагим Габибли on 14.02.2025.
//

import Foundation
import UIKit

protocol NetworkManagerProtocol {
    func getCharacters(completion: @escaping ([Character]?, Error?) -> Void)

    func loadImage(from urlString: String, completion: @escaping (Data?, Error?) -> Void)
}
