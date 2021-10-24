//
//  PostsDetailsSceneWorker.swift
//  PostsApp
//

import Foundation

protocol PostDetailsWorker {
    func fetchPostDetails(id: Int, completion: @escaping PostDetailsResponse) -> URLSessionDataTask?
}

final class PostDetailsWorkerImplementation {}

typealias PostDetailsResponse = (Result<PostModel, Error>) -> Void

extension PostDetailsWorkerImplementation: PostDetailsWorker {
    func fetchPostDetails(id: Int, completion: @escaping PostDetailsResponse) -> URLSessionDataTask? {
        
        let contactRequestModel = APIRequestModel(api: PostsAPI.fetchPostDetails(id: id), parameters: nil)
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
