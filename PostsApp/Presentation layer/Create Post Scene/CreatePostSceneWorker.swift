//
//  CreatePostSceneWorker.swift
//  PostsApp
//

import Foundation

protocol CreatePostWorker {
    func createPost(post:PostModel, completion: @escaping PostDetailsResponse) -> URLSessionDataTask?
}

typealias CreatePostResponse = (Result<PostModel, Error>) -> Void

final class CreatePostWorkerImplementation {}

extension CreatePostWorkerImplementation: CreatePostWorker {
    
    func createPost(post: PostModel, completion: @escaping PostDetailsResponse) -> URLSessionDataTask? {
        
        let params = post.dictionary
        let contactRequestModel = APIRequestModel(api: PostsAPI.createPost(postModel: post), parameters: params)
        return WebserviceHelper.requestAPI(apiModel: contactRequestModel) { response in
            switch response {
            case .success(let serverData):
                JSONResponseDecoder.decodeFrom(serverData, returningModelType: PostModel.self, completion: { (postResponse, error) in
                    if let parserError = error {
                        completion(.failure(parserError))
                        return
                    }
                    
                    if let postResponse = postResponse {
                        completion(.success(postResponse))
                        return
                    }
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

