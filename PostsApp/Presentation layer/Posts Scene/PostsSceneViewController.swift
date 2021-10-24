//
//  PostsSceneViewController.swift
//  PostsApp
//

import UIKit

protocol PostsPresenterOutput: AnyObject {
    func presenter(retrieveItems items: [PostModel])
    func presenter(itemSelected itemId: Int)
    func presenter_ItemDeleted()
}

protocol PostsViewControllerOutput {}

final class PostsViewController: UIViewController {
    var interactor: PostsInteractor?
    var router: PostsRouter?
    
    var items = [PostModel]()
    let userId = 1

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Posts"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setup()
        self.registerNib()
        
        
        
        let button1 = UIBarButtonItem(image: UIImage(named: "ic_add"), style: .plain, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem  = button1
    }
    override func viewWillAppear(_ animated: Bool) {
        self.showLoader()
        self.interactor?.viewDidLoad(userId: self.userId)
    }
    
    @objc func addButtonTapped() {
        self.router?.showCreatePost()
    }
    
    func registerNib() {
        tableView.register(UINib.init(nibName: "TitleSubtitleTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    //MARK: Setup Clean Code Design Pattern
    
    func setup() {
        let viewController = self
        let interactor = PostsInteractorImplementation()
        let presenter = PostsPresenterImplementation()
        let router = PostsRouterImplementation()
        let worker = PostsWorkerImplementation()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.source = self
        router.navigationController = viewController.navigationController
    }
    
    private func showLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    private func hideLoader() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        tableView.isHidden = false
    }
    
}

extension PostsViewController: PostsPresenterOutput {
    func presenter_ItemDeleted() {
        self.tableView.reloadData()
    }
    
    func presenter(itemSelected itemId: Int) {
        self.router?.showPostsDetails(with: itemId)
    }
    
    func presenter(retrieveItems items: [PostModel]) {
        self.items = items
        self.hideLoader()
        self.tableView.reloadData()
    }
}

//MARK: TableView Delegate and DataSource

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TitleSubtitleTableViewCell
        cell.title_Label.text = items[indexPath.row].title
        cell.subTitle_Label.text = items[indexPath.row].body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.interactor?.didSelectRow(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // MARK: Delete Post
        let deleteItem = UIContextualAction(style: .destructive, title: "") {  (contextualAction, view, boolValue) in
            
            let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete this post?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { action in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }))
            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
                self.interactor?.deletePost(with: self.items[indexPath.row].id ?? 0)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        deleteItem.image = UIImage(named: "ic_delete")
        
        // MARK: Edit Post
        let updateItem = UIContextualAction(style: .normal, title: "") {  (contextualAction, view, boolValue) in
            self.router?.showEditPost(post: self.items[indexPath.row])
        }
        updateItem.image = UIImage(named: "ic_edit")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem, updateItem])
        
        return swipeActions
    }
}
