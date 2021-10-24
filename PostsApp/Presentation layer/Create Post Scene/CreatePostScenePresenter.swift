//
//  CreatePostScenePresenter.swift
//  PostsApp
//

import UIKit

protocol CreatePostPresenter {
    func interactor_DidCreatePost()
}

final class CreatePostPresenterImplementation {
    weak var viewController: CreatePostPresenterOutput?
}

extension CreatePostPresenterImplementation: CreatePostPresenter {
    func interactor_DidCreatePost() {
        self.viewController?.presenter_DidCreatePost()
    }
}
