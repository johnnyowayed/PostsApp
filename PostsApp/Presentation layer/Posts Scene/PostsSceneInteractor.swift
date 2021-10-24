//
//  PostsSceneInteractor.swift
//  PostsApp
//

import Foundation

protocol PostsInteractor {
    func viewDidLoad(userId: Int)
    func deletePost(with id: Int)
    func didSelectRow(at index: Int)
}

final class PostsInteractorImplementation {
    var presenter: PostsPresenter?
    var worker: PostsWorker?
    private var items = [PostModel]()
}

extension PostsInteractorImplementation: PostsInteractor {
    
    func viewDidLoad(userId: Int) {
       let _ = self.worker?.fetchPosts(userId: userId, completion: { apiResult in
            DispatchQueue.main.async {
                switch apiResult {
                case .success(let postsList):
                    self.items = postsList
                    self.presenter?.interactor(didFetchItems: self.items)
                case .failure(_):
                    print()
                }
            }
        })
    }
    
    func deletePost(with id: Int) {
        let _ = self.worker?.deletePost(id: id, completion: { apiResult in
            DispatchQueue.main.async {
                switch apiResult {
                case .success(_):
                    self.presenter?.interactor_ItemDeleted()
                case .failure(_):
                    print()
                }
            }
        })
    }
    
    func didSelectRow(at index: Int) {
        presenter?.interactor(didSelectItem: self.items[index])
    }
}
