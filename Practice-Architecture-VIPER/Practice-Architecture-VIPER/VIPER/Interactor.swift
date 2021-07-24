//
//  Interactor.swift
//  Practice-Architecture-VIPER
//
//  Created by Alice Chang on 2021/7/24.
//

import Foundation

// object
// protocol
// ref to presenter


protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUser()
}

class UserInteactor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUser() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUser(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try! JSONDecoder().decode([User].self, from:data)
                self?.presenter?.interactorDidFetchUser(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchUser(with: .failure(FetchError.failed))
            }
        }
     
        task.resume()
    }
}
