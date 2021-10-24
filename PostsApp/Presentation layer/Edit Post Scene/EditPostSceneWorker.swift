//
//  EditPostSceneWorker.swift
//  PostsApp
//

import Foundation

protocol EditPostWorker {
    func editPost(post:PostModel, completion: @escaping EditPostResponse) -> URLSessionDataTask?
}

typealias EditPostResponse = (Result<PostModel, Error>) -> Void

final class EditPostWorkerImplementation {}

extension EditPostWorkerImplementation: EditPostWorker {
    func editPost(post: PostModel, completion: @escaping EditPostResponse) -> URLSessionDataTask? {
        let params = post.dictionary
        let contactRequestModel = APIRequestModel(api: PostsAPI.updatePost(postModel: post), parameters: params)
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
