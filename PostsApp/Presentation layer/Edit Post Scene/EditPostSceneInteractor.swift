//
//  EditPostSceneInteractor.swift
//  PostsApp
//

import Foundation

protocol EditPostInteractor {
    func editPost(post: PostModel)
}

final class EditPostInteractorImplementation {
    var presenter: EditPostPresenter?
    var worker: EditPostWorker?
}

extension EditPostInteractorImplementation: EditPostInteractor {
    
    func editPost(post: PostModel) {
        let _ = worker?.editPost(post: post, completion: { apiResult in
            switch apiResult {
            case .success(_):
                self.presenter?.interactor_DidEditPost()
            case .failure(_):
                print() // Display Error
            }
        })
    }
}
