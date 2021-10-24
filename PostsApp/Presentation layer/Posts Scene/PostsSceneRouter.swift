//
//  PostsSceneRouter.swift
//  PostsApp
//

import UIKit

protocol PostsRouter {
    func showPostsDetails(with id:Int)
    func showCreatePost()
    func showEditPost(post:PostModel)
}

final class PostsRouterImplementation: NSObject {
    weak var source: UIViewController?
    weak var navigationController: UINavigationController?
}

extension PostsRouterImplementation: PostsRouter {
    
    // MARK: Go To Post Details
    
    func showPostsDetails(with id: Int) {
        let storyboard = UIStoryboard(name: "PostDetailsView", bundle: nil)
        guard let postDetailsVC = storyboard.instantiateViewController(withIdentifier: "PostsDetailsViewController") as? PostsDetailsViewController else {
            return
        }
        postDetailsVC.itemId = id
        navigationController?.pushViewController(postDetailsVC, animated: true)
    }
    
    // MARK: Go To Create Post
    
    func showCreatePost() {
        let storyboard = UIStoryboard(name: "CreatePostView", bundle: nil)
        guard let createPostVC = storyboard.instantiateViewController(withIdentifier: "CreatePostViewController") as? CreatePostViewController else {
            return
        }
        source?.present(createPostVC, animated: true, completion: nil)
    }
    
    // MARK: Go To Edit Post
    
    func showEditPost(post: PostModel) {
        let storyboard = UIStoryboard(name: "EditPostView", bundle: nil)
        guard let editPostVC = storyboard.instantiateViewController(withIdentifier: "EditPostViewController") as? EditPostViewController else {
            return
        }
        editPostVC.postData = post
        source?.present(editPostVC, animated: true, completion: nil)
    }
    
}
