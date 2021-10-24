//
//  APIBuilder.swift
//  PostsApp
//
//  Created by Johnny on 21/10/2021.
//

///  This API will hold all APIs related to restaurant
enum PostsAPI {
    case fetchPosts(userId: Int)
    case deletePost(id: Int)
    case fetchPostDetails(id: Int)
    case updatePost(postModel: PostModel)
    case createPost(postModel: PostModel)
}

extension PostsAPI: APIProtocol {
    func httpMthodType() -> HTTPMethodType {
        var methodType = HTTPMethodType.get
        switch self {
        case .fetchPosts(_):
            methodType = .get
        case .deletePost(_):
            methodType = .delete
        case .fetchPostDetails(_):
            methodType = .get
        case .updatePost(_):
            methodType = .put
        case .createPost(_):
            methodType = .post
        }
        return methodType
    }

    func apiEndPath() -> String {
        var apiEndPath = ""
        switch self {
        case .fetchPosts(let userId):
            apiEndPath += "?userId=\(userId)"
        case .deletePost(let id):
            apiEndPath += "/\(id)"
        case .fetchPostDetails(id: let id):
            apiEndPath += "/\(id)"
        case .updatePost(let postModel):
            apiEndPath += "/\(postModel.id ?? 0)"
        case .createPost(_):
            apiEndPath += ""
        }
        return apiEndPath
    }
    
    func apiBasePath() -> String {
        return WebserviceConstants.baseURL
    }
}
