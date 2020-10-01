//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by RYAN GREENBURG on 9/30/20.
//

import UIKit

class ViewController: UIViewController {
    
    let colors: [UIColor] = [.blue, .cyan, .green, .magenta, .orange, .red, .yellow, .purple, .systemIndigo]

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = configureCollectionViewLayot()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
        
        cell.backgroundColor = colors[indexPath.row]
        
       return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideSize = self.view.frame.width / 2 - 14.5
        return CGSize(width: sideSize, height: sideSize)
    }
    
    func configureCollectionViewLayot() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 8,
                                      leading: 8,
                                      bottom: 0,
                                      trailing: 8)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedColor = colors[indexPath.row]
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else { return }
        viewController.view.backgroundColor = selectedColor
        present(viewController, animated: true)
    }
}
