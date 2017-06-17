//
//  KeyboardViewController.swift
//  ChippmojiKeyboard
//
//  Created by Sivaraj-Pasumalaithevan (Contractor) on 6/15/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import UIKit
import QuartzCore


class KeyboardViewController: UIInputViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, KeyboardActionHandler {
  
  
  @IBOutlet var keyboardView: KeyboardView!
  @IBOutlet weak var menuView: UIView!

  var collectionView: UICollectionView!
  var toastView: UIView!
  static let kReuseIdentifier: String = "ChippMojiCell"
  var pathDictionary = [IndexPath: Int]()
  var currentImages = EmojiDefs.danceImages
  
  func isLandscape() -> Bool {
    return UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    print("test")
    Bundle.main.loadNibNamed("KeyboardView", owner: self, options: nil)
    self.view.addSubview(keyboardView)
    self.keyboardView.delegate = self
    print ("frame", self.view.frame.width, self.view.frame.height)
    let borderWidth: CGFloat = 1.0
    self.view.layer.borderWidth = borderWidth
    self.view.layer.cornerRadius = 0.5
    self.view.layer.borderColor = UIColor.lightGray.cgColor
    menuView.layer.borderWidth = borderWidth
    menuView.frame = menuView.frame.insetBy(dx: -borderWidth, dy: -borderWidth);
    menuView.layer.borderColor = UIColor.lightGray.cgColor
  
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if keyboardView == nil {
      return
    }
    print ("frame", self.view.frame.width, self.view.frame.height)
    let rect = CGRect(origin: CGPoint(x: 15, y: 0), size: CGSize(width: self.view.frame.width - 30, height: 150))
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: 80, height: 80)
    collectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
    collectionView.backgroundColor = UIColor.white
    
    collectionView.delegate = self
    collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: KeyboardViewController.kReuseIdentifier)
    collectionView.dataSource = self
    self.view.addSubview(collectionView)
    toastView = UIView(frame: collectionView.frame)
    toastView.backgroundColor = UIColor.clear
    toastView.isUserInteractionEnabled = false
    self.view.addSubview(toastView)
    //TODO SIVA
    //self.keyboardView.deleteButton.isHidden = isLandscape()
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated
  }
  
  override func textWillChange(_ textInput: UITextInput?) {
    // The app is about to change the document's contents. Perform any preparation here.
  }
  
  override func textDidChange(_ textInput: UITextInput?) {
    
  }
  
  func lipsEmojiButtonClicked() {
    currentImages = EmojiDefs.imageForCategory(EmojiDefs.Categories.lips)
    collectionView.reloadData()
  }
  
  func speechEmojiButtonClicked() {
    currentImages = EmojiDefs.imageForCategory(EmojiDefs.Categories.speech)
    collectionView.reloadData()
  }
  
  func deleteButtonClicked() {
    // Delete backward twice becuase there is a newline
    // after the image is pasted into the label.
    self.textDocumentProxy.deleteBackward()
    self.textDocumentProxy.deleteBackward()
  }
  
  func danceEmojiButtonClicked() {
    currentImages = EmojiDefs.imageForCategory(EmojiDefs.Categories.dance)
    collectionView.reloadData()
  }

  
  func nextKeyboardButtonClicked() {
    super.advanceToNextInputMode()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return currentImages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: KeyboardViewController.kReuseIdentifier, for: indexPath)
    let image = UIImageView(frame: cell.frame)
    let name = self.currentImages[indexPath.row + indexPath.section]
    let uiimage = UIImage(named: "\(name)")
    image.image = uiimage
    cell.backgroundView = image
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as UICollectionViewCell!
    cell?.backgroundColor = UIColor.gray
  }
  
  func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as UICollectionViewCell!
    cell?.backgroundColor = UIColor.white
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        UIPasteboard.general.isPersistent = true
    let imageName = currentImages[indexPath.row + indexPath.section]
    let image = UIImage(named: imageName)!
    self.toastView.makeToast("Chippmoji copied. Now paste it!")
    UIPasteboard.general.image = scaleImageDown(image, scale: 0.5)
  }
  
  func scaleImageDown(_ image: UIImage, scale: CGFloat) -> UIImage {
    let size = image.size.applying(CGAffineTransform(scaleX: scale, y: scale))
    let hasAlpha = true
    let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
    
    UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
    image.draw(in: CGRect(origin: CGPoint.zero, size: size))
    
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return scaledImage!
  }
  
  static func hasFullAccess() -> Bool {
    return UIPasteboard.general.isKind(of: UIPasteboard.self)
  }

  
}