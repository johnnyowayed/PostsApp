//
//  CreatePostSceneInteractor.swift
//  PostsApp
//

import Foundation

protocol CreatePostInteractor {
    func createPost(post:PostModel)
}

final class CreatePostInteractorImplementation {
    var presenter: CreatePostPresenter?
    var worker: CreatePostWorker?
}

extension CreatePostInteractorImplementation: CreatePostInteractor {
    func createPost(post: PostModel) {
        let _ = worker?.createPost(post: post, completion: { apiResult in
            switch apiResult {
            case .success(_):
//                self.items = postsList
                self.presenter?.interactor_DidCreatePost()
            case .failure(_):
                print()
                // Display Error
            }
        })
    }
    
}
