//
//  PostsScenePresenter.swift
//  PostsApp
//

import UIKit

protocol PostsPresenter {
    func interactor(didSelectItem item: PostModel)
    func interactor(didFetchItems items: [PostModel])
    func interactor_ItemDeleted()
}

final class PostsPresenterImplementation {
    weak var viewController: PostsPresenterOutput?
}

extension PostsPresenterImplementation: PostsPresenter {
    
    func interactor(didFetchItems items: [PostModel]) {
        viewController?.presenter(retrieveItems: items)
    }
    
    func interactor(didSelectItem item: PostModel) {
        viewController?.presenter(itemSelected: item.id ?? 0 )
    }
    
    func interactor_ItemDeleted() {
        viewController?.presenter_ItemDeleted()
    }
    
    
}
