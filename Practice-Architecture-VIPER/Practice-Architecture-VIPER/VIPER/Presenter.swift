//
//  Presenter.swift
//  Practice-Architecture-VIPER
//
//  Created by Alice Chang on 2021/7/24.
//

import Foundation

// Object
// protocl
// ref to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol  AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUser(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUser()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchUser(with result: Result<[User], Error>) {
        switch result {
        case .success(let user):
            view?.update(with: user)
        case .failure:
            view?.update(with: "Something went wrong")
        }
        
    }
    
}
