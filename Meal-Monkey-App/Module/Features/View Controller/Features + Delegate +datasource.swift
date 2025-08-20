//
//  Features + Delegate +datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 20/08/25.
//

import Foundation
import UIKit

/// Extension for `FeaturesViewController`
/// Conforms to `UICollectionViewDelegate`, `UICollectionViewDataSource`, and `UICollectionViewDelegateFlowLayout`
/// to manage the features collection view.
extension FeaturesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionView DataSource Methods
    /// Returns the number of items (features) to display in the collection view.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFeatures.count
    }
    
    /// Configures and returns a cell for the given index path.
    /// - Parameters:
    ///   - collectionView: The collection view requesting the cell.
    ///   - indexPath: The index path of the item.
    /// - Returns: A configured `FeaturesCollectionViewCell`.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : FeaturesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturesCollectionViewCell", for: indexPath) as! FeaturesCollectionViewCell
        let obj = arrFeatures[indexPath.row]
        cell.configFeature(features: obj)
        return cell
    }
    
    // MARK: - UICollectionView DelegateFlowLayout Method
    /// Specifies the size for each collection view item.
    /// - Parameters:
    ///   - collectionView: The collection view requesting the size.
    ///   - collectionViewLayout: The layout object requesting the size information.
    ///   - indexPath: The index path of the item.
    /// - Returns: A `CGSize` representing the width and height of the item.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

/// Extension for handling scroll view events related to the features collection view.
extension FeaturesViewController: UIScrollViewDelegate {
    // MARK: - UIScrollView Delegate Method
    /// Called when scrolling ends. Updates the page control and labels based on the current page.
    /// - Parameter scrollView: The scroll view that finished decelerating.
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageController.currentPage = pageNumber
        updateLabels(for: pageNumber)
    }
}
