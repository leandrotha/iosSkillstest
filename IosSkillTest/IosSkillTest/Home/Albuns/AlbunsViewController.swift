//
//  AlbunsViewController.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 31/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AlbunsViewController: BaseTableViewController {
    
    //MARK: - Properties
    
    var albuns: [Album] = []
    let reuse = "customcell"
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAlbuns()
    }
    
    //MARK: - Methods
    
    override func setupView() {
        super.setupView()
        
        self.title = "Álbuns"
        tableView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: reuse)
    }
    
    func fetchAlbuns() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {return}
        
        showSpinner()
        
        Alamofire.request(url).responseJSON(queue: DispatchQueue.global(), options: .allowFragments, completionHandler: { response in
            switch response.result {
            case .success:
                self.stopSpinner()
                
                do {
                    self.albuns = try Parser.parseAlbum(response.data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let error {
                    self.handleDefaultError(error)
                }
                
            case .failure:
                self.stopSpinner()
                self.handleDefaultError(response.error ?? NSError())
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albuns.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: reuse, for: indexPath) as? AlbumCell
        
        guard let cell = c else {return UITableViewCell()}
        
        cell.lblTitle?.text = albuns[indexPath.row].title ?? ""
        cell.ivPhoto?.downloadImage(url: URL(string: albuns[indexPath.row].thumbNail ?? ""))
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PhotoViewController()
        vc.url = albuns[indexPath.row].url ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
