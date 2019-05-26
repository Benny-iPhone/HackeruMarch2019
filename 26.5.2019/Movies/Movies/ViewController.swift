//
//  ViewController.swift
//  Movies
//
//  Created by hackeru on 26/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var collectionArray : [MovieResponse.Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        fetchMovies()
    }
    
    private func fetchMovies(){
        let request = AppRequest(endpoint: .discoverMovie)
        request.sendRequest { [weak self](data, error) in
            guard let data = data else{
                //TODO: - Handle Error
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "")
            
            guard let response = try? JSONDecoder().decode(MovieResponse.self, from: data) else{
                print("parsing failed")
                return
            }
            
            self?.collectionArray = response.results
            self?.reloadCollectionView()
        }
    }


}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func reloadCollectionView(){
        guard Thread.isMainThread else{
            DispatchQueue.main.async {
                self.reloadCollectionView()
            }
            return
        }
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCell
        cell.populate(with: collectionArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}


