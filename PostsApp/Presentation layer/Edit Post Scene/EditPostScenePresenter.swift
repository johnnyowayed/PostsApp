//
//  EditPostScenePresenter.swift
//  PostsApp
//

import UIKit

protocol EditPostPresenter {
    func interactor_DidEditPost()
}

final class EditPostPresenterImplementation {
    weak var viewController: EditPostPresenterOutput?
}

extension EditPostPresenterImplementation: EditPostPresenter {
    func interactor_DidEditPost() {
        self.viewController?.presenter_DidEditPost()
    }
}
