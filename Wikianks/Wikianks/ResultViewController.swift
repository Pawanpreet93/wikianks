//
//  ResultViewController.swift
//  Wikianks
//
//  Created by Pawan on 18/08/17.
//  Copyright © 2017 Pawan. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var trueFalseStatus = [Bool]()
    var points = 0
    
    @IBOutlet var statusCollectionView: UICollectionView!{
        didSet{
            statusCollectionView.delegate = self
            statusCollectionView.dataSource = self
        }
    }
    @IBOutlet var percentageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(points)
        print(trueFalseStatus.count)
        let percentage = Int((points * 100) / trueFalseStatus.count)
        percentageLabel.text = "\(percentage)%"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trueFalseStatus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as! ResultCollectionViewCell
        
        if trueFalseStatus[indexPath.row]{
            cell.statusImageView.image = UIImage(named: "right")
        }else{
            cell.statusImageView.image = UIImage(named: "wrong")
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    
    func share(){
        let shareText = "I scored \(percentageLabel.text ?? "100%") on Wikianks!"
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func shareResult(_ sender: Any) {
        share()
    }

    
}


class ResultCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet var bgView:UIView!{
        didSet{
            bgView.backgroundColor = brandColor
            bgView.layer.cornerRadius =  15//bgView.frame.width/2
        }
    }
    
    @IBOutlet var statusImageView:UIImageView!
    
}













