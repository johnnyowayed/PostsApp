//
//  CreatePostSceneViewController.swift
//  PostsApp
//

import UIKit

protocol CreatePostPresenterOutput: AnyObject {
    func presenter_DidCreatePost()
}

final class CreatePostViewController: UIViewController {
    var interactor: CreatePostInteractor?
    
    @IBOutlet weak var title_TextField: UITextField!
    @IBOutlet weak var description_TextField: UITextField!
    @IBOutlet weak var confirm_Button: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Post"
        self.confirm_Button.setTitle("Create", for: .normal)
        self.confirm_Button.layer.cornerRadius = 8
        self.setup()
    }
}

//MARK: - Setup Clean Code Design Pattern

extension CreatePostViewController {
    func setup() {
        let viewController = self
        let interactor = CreatePostInteractorImplementation()
        let presenter = CreatePostPresenterImplementation()
        let worker = CreatePostWorkerImplementation()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
    }
}

extension CreatePostViewController: CreatePostPresenterOutput {
    func presenter_DidCreatePost() {
        DispatchQueue.main.async {
            self.hideLoader()
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - IBAction

extension CreatePostViewController {
    @IBAction func confimButtonPressed() {
        let title = self.title_TextField.text ?? ""
        let body = self.description_TextField.text ?? ""
        self.showLoader()
        self.interactor?.createPost(post: PostModel.init(userId: nil, id: nil, title: title, body: body))
    }
}

//MARK: - Activity Indicator Handling

extension CreatePostViewController {
    private func showLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func hideLoader() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
    }
}

