//
//  ViewController.swift
//  AccentureTechnical
//
//  Created by Daniel Marco Rafanan on 7/21/22.
//

import UIKit


class PictureListViewController: UIViewController {
    // MARK: ViewModel
    private var viewModel:PictureListViewModel
    
    init(viewModel:PictureListViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getNewPictures()
        
    }
    
    // MARK: UI
    private let tableView:UITableView = UITableView()

    
    private func setupUI(){
        title = "Picture List"
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PictureTableViewCell.self, forCellReuseIdentifier: PictureTableViewCell.reuseIdentifier)
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
    
    @objc private func refreshTableView(){
        viewModel.getNewPictures()
    }
}

extension PictureListViewController:PictureListViewModelDelegate{
    func didRecieveNewPictureModels() {
        tableView.reloadData()
    }
    
    func didRecieve(networkError: NetworkError) {
        let alert = UIAlertController(title: "Error", message: "There was a network problem.", preferredStyle: .alert)
        present(alert, animated: true)
    }
    
    func isGettingPictures(_ isGettingPictures: Bool) {
        if (isGettingPictures){
            tableView.refreshControl?.beginRefreshing()
        }else{
            tableView.refreshControl?.endRefreshing()
        }
    }
    
    
}
extension PictureListViewController:UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pictureModels.count
    }
    
    
}
extension PictureListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PictureTableViewCell.reuseIdentifier, for: indexPath) as? PictureTableViewCell else { return UITableViewCell()}
        cell.setup(pictureModel: viewModel.pictureModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tappedCell(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

