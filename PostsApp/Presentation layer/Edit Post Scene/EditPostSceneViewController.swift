//
//  EditPostSceneViewController.swift
//  PostsApp
//

import UIKit

protocol EditPostPresenterOutput: AnyObject {
    func presenter_DidEditPost()
}

final class EditPostViewController: UIViewController {
    var interactor: EditPostInteractor?
    
    @IBOutlet weak var title_TextField: UITextField!
    @IBOutlet weak var description_TextField: UITextField!
    @IBOutlet weak var confirm_Button: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }
    
    var postData:PostModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Edit Post"
        self.confirm_Button.setTitle("Edit", for: .normal)
        self.confirm_Button.layer.cornerRadius = 8
        self.setup()
    }
    
    func setupUI() {
        self.title_TextField.text = postData.title
        self.description_TextField.text = postData.body
    }
}

//MARK: - Setup Clean Code Design Pattern

extension EditPostViewController {
    func setup() {
        let viewController = self
        let interactor = EditPostInteractorImplementation()
        let presenter = EditPostPresenterImplementation()
        let worker = EditPostWorkerImplementation()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
    }
}

//MARK: - EditPostPresenterOutput

extension EditPostViewController: EditPostPresenterOutput {
    func presenter_DidEditPost() {
        DispatchQueue.main.async {
            self.hideLoader()
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - IBAction

extension EditPostViewController {
    @IBAction func confimButtonPressed() {
        let title = self.title_TextField.text ?? ""
        let body = self.description_TextField.text ?? ""
        self.showLoader()
        self.interactor?.editPost(post: PostModel.init(userId: nil, id: nil, title: title, body: body))
    }
}

//MARK: - Activity Indicator Handling

extension EditPostViewController {
    
    private func showLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func hideLoader() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
    }
}
