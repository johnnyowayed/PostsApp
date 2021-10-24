//
//  PostsDetailsSceneInteractor.swift
//  PostsApp
//

import Foundation

protocol PostDetailsInteractor {
    func viewDidLoad(id: Int)
}

final class PostDetailsInteractorImplementation {
    var presenter: PostsDetailsPresenter?
    var worker: PostDetailsWorker?
}

extension PostDetailsInteractorImplementation: PostDetailsInteractor {
    
    func viewDidLoad(id: Int) {
        let _ = self.worker?.fetchPostDetails(id: id, completion: { apiResult in
            switch apiResult {
            case .success(let postDetails):
                self.presenter?.interactor(didFetchPostDetails: postDetails)
            case .failure(_):
                print()
                // Display Error
            }
        })
      
    }
    
}
