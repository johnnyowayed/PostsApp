//
//  PostsDetailsScenePresenter.swift
//  PostsApp
//

import UIKit

protocol PostsDetailsPresenter {
    func interactor(didFetchPostDetails post: PostModel)
}

final class PostsDetailsPresenterImplementation {
    weak var viewController: PostsDetailsPresenterOutput?
}

extension PostsDetailsPresenterImplementation: PostsDetailsPresenter {
    
    func interactor(didFetchPostDetails post: PostModel) {
        var postDetails: [PostDetailsModel] = [PostDetailsModel]()
        
        postDetails.append(PostDetailsModel.init(title: "Title", description: post.title))
        postDetails.append(PostDetailsModel.init(title: "Description", description: post.body))
        self.viewController?.presenter(postDetails: postDetails)
        
    }
}
