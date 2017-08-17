//
//  FillUpViewController.swift
//  Wikianks
//
//  Created by Pawan on 11/08/17.
//  Copyright © 2017 Pawan. All rights reserved.
//

import UIKit

extension MutableCollection where Indices.Iterator.Element == Index {
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

class FillUpViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var paragraphText = "So, with large parts of Foundation missing, plus all “Core” and “Kit” frameworks completely absent, server-side Swift is significantly simpler. If you followed my books Hacking with Swift or Hacking with macOS, you’ll know that most of the learning is about figuring out how UIKit works. Not so with server-side Swift: because it’s significantly simpler, you can spend more time focusing on how to build projects with what you know rather than always having to learn new things. Because Apple’s framework footprint is significantly smaller, third-party libraries step in to fill the gaps. That’s where Kitura comes in: it’s a framework developed by IBM to provide the tools we need to build web apps and websites."
    
    @IBOutlet weak var paragraphTextView:UITextView!{
        didSet{
            paragraphTextView.font = UIFont(name: fontNamePrimary, size: 16.0)
        }
    }

    @IBOutlet weak var wordsCollectionView:UICollectionView!{
        didSet{
            wordsCollectionView.delegate = self
            wordsCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var showResultButton: CustomBGButton!
    
    var currentIndex = 0
    var blank = " ____ "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSentences()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var finalSentences = [String]()
    var finalWordsThatGotReplaced = [String]()
    var jumbledWordsToShow = [String]()
    
    func createSentences(){
        
        let sentences = paragraphText.components(separatedBy: ". ")
        
        let wordsToBeReplaced = [" is ", " of ", " or ", " an ", " can ", " to ", " a "].shuffled()
        
        for index in 0..<sentences.count{
            
            for eachWord in wordsToBeReplaced{
                
                if sentences[index].contains("\(eachWord)"){
                    
                    let range = sentences[index].range(of: eachWord)
                    
                    finalWordsThatGotReplaced.append(eachWord)
                    
                    if range != nil{
                        var tempSentence = sentences[index]
                        tempSentence.replaceSubrange(range!, with: blank)
                        finalSentences.append(tempSentence)
                    }
                    
                    break
                    
                }
                
            }
        }
        
        setupTextView(forIndex: 0)
        jumbledWordsToShow = finalWordsThatGotReplaced.shuffled()
        print(finalWordsThatGotReplaced)
    }
    
    func setupTextView(forIndex: Int){
        
        let attributedStringForTextView = NSMutableAttributedString()
        
        for index in 0..<finalSentences.count{
            
            if index == forIndex{
                attributedStringForTextView.append(NSAttributedString(string: finalSentences[index] + ". ", attributes: [NSForegroundColorAttributeName: brighterBrandColor, NSFontAttributeName: UIFont(name: fontNamePrimary, size: 16.0)!]))
            }else{
                attributedStringForTextView.append(NSAttributedString(string: finalSentences[index] + ". ", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont(name: fontNamePrimary, size: 16.0)!]))
            }
        }
        
        paragraphTextView.attributedText = attributedStringForTextView
        
    }
    
    func insertSelectedWordBack(forIndex: Int, replacementWord: String){
        
        if replacementWord == finalWordsThatGotReplaced[forIndex]{
            print("Points Increased")
        }
        
        finalSentences[forIndex] = finalSentences[forIndex].replacingOccurrences(of: blank, with: replacementWord)
        
        if let index = jumbledWordsToShow.index(of: replacementWord){
            jumbledWordsToShow.remove(at: index)
            wordsCollectionView.reloadData()
        }
        
        
        currentIndex += 1
        
        setupTextView(forIndex: currentIndex)

        if currentIndex == finalWordsThatGotReplaced.count{
            print("Segue")
            showResultButton.isHidden = false
            wordsCollectionView.isHidden = true
        }
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jumbledWordsToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordsCollectionViewCell", for: indexPath) as! WordsCollectionViewCell
        
//        cell.word.text = jumbledWordsToShow[indexPath.row]
        cell.wordForCell = jumbledWordsToShow[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let word: NSString = jumbledWordsToShow[indexPath.row] as NSString
        let labelSize: CGSize = word.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17.0)])
        return CGSize(width: labelSize.width + 50, height: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cellAtIndexPath = collectionView.cellForItem(at: indexPath) as? WordsCollectionViewCell{
            if cellAtIndexPath.wordForCell != nil{
                insertSelectedWordBack(forIndex: currentIndex, replacementWord: cellAtIndexPath.wordForCell!)
            }
        }
        
    }
    
}

class WordsCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var bgView: UIView!{
        didSet{
            bgView.layer.cornerRadius = 8
            bgView.backgroundColor = brandColor
        }
    }
    @IBOutlet weak var word: UILabel!{
        didSet{
            word.font = UIFont(name: fontNamePrimary, size: 16.0)
            word.textColor = fontColorOnBrandColor
        }
    }
    
    var wordForCell: String?{
        didSet{
            word.text = wordForCell
        }
    }
    
    
}

