//
//  ViewController.swift
//  RMCoreDataCleanSwift
//
//  Created by Ибрагим Габибли on 11.02.2025.
//

import UIKit
import SnapKit

final class CharacterViewController: UIViewController {
    var interactor: CharacterInteractorProtocol?
    var storageManager: StorageManagerProtocol?

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        return tableView
    }()

    var characters = [Entity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        getCharacters()
    }

    private func setupNavigationBar() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterTableViewCell.self,
                           forCellReuseIdentifier: CharacterTableViewCell.id)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func getCharacters() {
        interactor?.getCharacters(request: CharacterModel.Request())
    }
}

// MARK: - CharacterViewProtocol
extension CharacterViewController: CharacterViewProtocol {
    func displayCharacters(viewModel: CharacterModel.ViewModel) {
        self.characters = viewModel.characters
        tableView.reloadData()
    }

    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterTableViewCell.id,
            for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }

        let character = characters[indexPath.row]

        guard let imageData = storageManager?.fetchImageData(forCharacterId: character.id),
              let image = UIImage(data: imageData) else {
            return cell
        }

        cell.configure(with: character, image: image)

        return cell
    }
}

// MARK: - UITableViewDelegate
extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        128
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
