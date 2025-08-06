//
//  FeaturesViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

class FeaturesViewController: UIViewController {
    
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    var arrService:[String] = ["ic_Fast_Delvery","ic_Find_Food","ic_Live_Tracking"]
    var arrFeatures : [Features] = Features.addData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = "Find Food You Love"
        lblSubTitle.text = "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"
        viewStyle(textfield: [btnNext])
        self.navigationItem.hidesBackButton = true
        colView.register(UINib(nibName: "FeaturesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturesCollectionViewCell")
    }
    
    func viewStyle(textfield: [UIView]){
        for item in textfield {
            item.viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray)
        }
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    func updateLabels(for page: Int) {
        switch page {
        case 0:
            lblTitle.text = "Find Food You Love"
            lblSubTitle.text = "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"
            btnNext.setTitle("Next", for: .normal)
        case 1:
            lblTitle.text = "Fast Delivery"
            lblSubTitle.text = "Fast food delivery to your home, office wherever you are"
            btnNext.setTitle("Next", for: .normal)
        case 2:
            lblTitle.text = "Live Tracking"
            lblSubTitle.text = "Real time tracking of your food on the app once you placed the order"
            btnNext.setTitle("Done", for: .normal)
        default:
            break
        }
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        let currentPage = pageController.currentPage
        if currentPage < arrService.count - 1 {
            // Scroll to next page
            let nextPage = currentPage + 1
            let xOffset = CGFloat(nextPage) * colView.frame.width
            colView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
            pageController.currentPage = nextPage
            updateLabels(for: nextPage)
        } else {
            let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            if let signUpVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                self.navigationController?.pushViewController(signUpVC, animated: true)
            }
        }
    }
}

extension FeaturesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFeatures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : FeaturesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturesCollectionViewCell", for: indexPath) as! FeaturesCollectionViewCell
        let obj = arrFeatures[indexPath.row]
        cell.configFeature(features: obj)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width + 10, height: collectionView.frame.height)
    }
}

extension FeaturesViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageController.currentPage = pageNumber
    }
}
