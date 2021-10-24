//
//  PostsSceneWorker.swift
//  PostsApp
//

import Foundation

protocol PostsWorker {
    func fetchPosts(userId: Int, completion: @escaping PostResponse) -> URLSessionDataTask?
    func deletePost(id: Int, completion: @escaping DeletePostResponse) -> URLSessionDataTask?
}

final class PostsWorkerImplementation {}

typealias PostResponse = (Result<[PostModel], Error>) -> Void
typealias DeletePostResponse = (Result<Bool, Error>) -> Void

extension PostsWorkerImplementation: PostsWorker {
    
    func fetchPosts(userId: Int, completion: @escaping PostResponse) -> URLSessionDataTask? {
        let contactRequestModel = APIRequestModel(api: PostsAPI.fetchPosts(userId: userId), parameters: nil)
        
        return WebserviceHelper.requestAPI(apiModel: contactRequestModel) { response in
            switch response {
            case .success(let serverData):
                JSONResponseDecoder.decodeFrom(serverData, returningModelType: Posts.self, completion: { (postsResponse, error) in
                    if let parserError = error {
                        completion(.failure(parserError))
                        return
                    }
                    
                    if let postsResponse = postsResponse {
                        completion(.success(postsResponse))
                        return
                    }
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deletePost(id: Int, completion: @escaping DeletePostResponse) -> URLSessionDataTask? {
        let contactRequestModel = APIRequestModel(api: PostsAPI.deletePost(id: id), parameters: nil)
        
        return WebserviceHelper.requestAPI(apiModel: contactRequestModel) { response in
            switch response {
            case .success(_):
                completion(.success(true))
                return
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
