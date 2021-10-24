//
//  PostsDetailsSceneViewController.swift
//  PostsApp
//

import UIKit

protocol PostsDetailsPresenterOutput: AnyObject {
    func presenter(postDetails: [PostDetailsModel])
}


final class PostsDetailsViewController: UIViewController {
    var interactor: PostDetailsInteractor?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }

    var itemId = 0
    var postDetails = [PostDetailsModel]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Post Details"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.setup()
        self.showLoader()
        self.interactor?.viewDidLoad(id: itemId)
        
        self.registerNib()
    }
    
    func registerNib() {
        tableView.register(UINib.init(nibName: "TitleSubtitleTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
}

extension PostsDetailsViewController: PostsDetailsPresenterOutput {
    func presenter(postDetails: [PostDetailsModel]) {
        self.postDetails = postDetails
        DispatchQueue.main.async {
            self.hideLoader()
            self.tableView.reloadData()
        }
    }    
}

extension PostsDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TitleSubtitleTableViewCell
        
        if !self.postDetails.isEmpty {
            cell.title_Label.text = self.postDetails[indexPath.row].title
            cell.subTitle_Label.text = self.postDetails[indexPath.row].description
            cell.subTitle_Label.numberOfLines = 0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: Setup Clean Code Design Pattern

extension PostsDetailsViewController {
    
    func setup() {
        let viewController = self
        let interactor = PostDetailsInteractorImplementation()
        let presenter = PostsDetailsPresenterImplementation()
        let worker = PostDetailsWorkerImplementation()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
    }
}

//MARK: - Activity Indicator Handling

extension PostsDetailsViewController {
    private func showLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func hideLoader() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
    }
}
