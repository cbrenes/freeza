import Foundation
import UIKit

class TopEntriesViewController: UITableViewController {

    static let showImageSegueIdentifier = "showImageSegue"
    let viewModel = TopEntriesViewModel(withClient: RedditClient())
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    let errorLabel = UILabel()
    let tableFooterView = UIView()
    let moreButton = UIButton(type: .system)
    var urlToDisplay: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomCells()
        configureViews()
        loadEntries()
    }
    
    func registerCustomCells() {
        let nib = UINib(nibName: CustomCell.Name.entryTableCustomTableViewCell.rawValue, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CustomCell.Name.entryTableCustomTableViewCell.rawValue)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        coordinator.animate(alongsideTransition: { [weak self] (context) in
            
            self?.configureErrorLabelFrame()
            
            }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == TopEntriesViewController.showImageSegueIdentifier {
            
            if let urlViewController = segue.destination as? URLViewController {
                
                urlViewController.url = self.urlToDisplay
            }
        }
    }

    @objc func retryFromErrorToolbar() {
        
        self.loadEntries()
        self.dismissErrorToolbar()
    }
    
    @objc func dismissErrorToolbar() {
        
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    @objc func moreButtonTapped() {
        
        self.moreButton.isEnabled = false
        self.loadEntries()
    }
    
    private func loadEntries() {

        self.activityIndicatorView.startAnimating()
        self.viewModel.loadEntries {
            
            self.entriesReloaded()
        }
    }
    
    private func configureViews() {

        func configureActivityIndicatorView() {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicatorView)
        }

        func configureTableView() {
            
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.estimatedRowHeight = 110.0

            self.tableFooterView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 80)
            self.tableFooterView.addSubview(self.moreButton)
            
            self.moreButton.frame = self.tableFooterView.bounds
            self.moreButton.setTitle("More...", for: [])
            self.moreButton.setTitle("Loading...", for: .disabled)
            self.moreButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            self.moreButton.addTarget(self, action: #selector(TopEntriesViewController.moreButtonTapped), for: .touchUpInside)
        }
        
        func configureToolbar() {

            self.configureErrorLabelFrame()

            let errorItem = UIBarButtonItem(customView: self.errorLabel)
            let flexSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let retryItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(TopEntriesViewController.retryFromErrorToolbar))
            let fixedSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            let closeItem = UIBarButtonItem(image: UIImage(named: "close-button"), style: .plain, target: self, action: #selector(TopEntriesViewController.dismissErrorToolbar))
            
            fixedSpaceItem.width = 12
            
            self.toolbarItems = [errorItem, flexSpaceItem, retryItem, fixedSpaceItem, closeItem]
        }
        
        configureActivityIndicatorView()
        configureTableView()
        configureToolbar()
    }
    
    private func configureErrorLabelFrame() {
        
        self.errorLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width - 92, height: 22)
    }
    
    private func entriesReloaded() {
        
        self.activityIndicatorView.stopAnimating()
        self.tableView.reloadData()
        
        self.tableView.tableFooterView = self.tableFooterView
        self.moreButton.isEnabled = true
        
        if self.viewModel.hasError {

            self.errorLabel.text = self.viewModel.errorMessage
            self.navigationController?.setToolbarHidden(false, animated: true)
        }
    }
}

extension TopEntriesViewController { // UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01 // this code reduce the size of the header to almost zero, zero is not valid as an output for this reason I used 0.01
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.Name.entryTableCustomTableViewCell.rawValue) as? EntryTableCustomTableViewCell else {
            return UITableViewCell()
        }
        cell.entry = self.viewModel.entries[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? EntryTableCustomTableViewCell else {
            return
        }
        //cell.containerView.shake() this has the logic for the shake animation
        self.urlToDisplay = cell.entry?.url
        self.performSegue(withIdentifier: TopEntriesViewController.showImageSegueIdentifier, sender: self)
    }
}
