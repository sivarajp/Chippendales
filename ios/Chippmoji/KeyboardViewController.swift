//
//  KeyboardViewController.swift
//  ChippmojiKeyboard
//
//  Created by Sivaraj-Pasumalaithevan (Contractor) on 6/15/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import UIKit
import QuartzCore
import MobileCoreServices


class KeyboardViewController: UIInputViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, KeyboardActionHandler {
  
    @IBOutlet weak var segmentControlOut: UISegmentedControl!
  
    @IBAction func segmentControl(_ sender: Any) {
    
    switch segmentControlOut.selectedSegmentIndex
      {
      case 0:
        self.segmentControlOut.setImage(UIImage(named:"icons_world_active"), forSegmentAt: 0)
        nextKeyboardButtonClicked()
      case 1:
        segmentControlResetImages()
        self.segmentControlOut.setImage(UIImage(named:"dancericon_active"), forSegmentAt: 1)
        danceEmojiButtonClicked()
      case 2:
        segmentControlResetImages()
        self.segmentControlOut.setImage(UIImage(named:"lips_active"), forSegmentAt: 2)
        lipsEmojiButtonClicked()
      case 3:
        segmentControlResetImages()
        self.segmentControlOut.setImage(UIImage(named:"speechbubble_active"), forSegmentAt: 3)
        speechEmojiButtonClicked()
      case 4:
        shareButtonClicked()
      case 5:
        deleteButtonClicked()
      default:
        break
      }
    }
  @IBOutlet var keyboardView: KeyboardView!
  @IBOutlet weak var menuView: UIView!
  @IBOutlet weak var deleteButton: UIButton!
  let imageCache = NSCache<NSString, AnyObject>()
  var collectionView: UICollectionView!
  var toastView: UIView!
  static let kReuseIdentifier: String = "ChippMojiCell"
  var pathDictionary = [IndexPath: Int]()
  var currentImages = EmojiDefs.danceImages
  var imageDir = "images/dancers"
  
  func segmentControlResetImages() {
    self.segmentControlOut.setImage(UIImage(named:"icons_world"), forSegmentAt: 0)
    self.segmentControlOut.setImage(UIImage(named:"dancericon"), forSegmentAt: 1)
    self.segmentControlOut.setImage(UIImage(named:"lips"), forSegmentAt: 2)
    self.segmentControlOut.setImage(UIImage(named:"speechbubble"), forSegmentAt: 3)
    self.segmentControlOut.setImage(UIImage(named:"share"), forSegmentAt: 4)
    self.segmentControlOut.setImage(UIImage(named:"backspace-light"), forSegmentAt: 5)
  }

  
  
  func isLandscape() -> Bool {
    return UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Bundle.main.loadNibNamed("KeyboardView", owner: self, options: nil)
    self.view.addSubview(keyboardView)
    self.keyboardView.delegate = self
    let borderWidth: CGFloat = 1.0
    self.view.layer.borderWidth = borderWidth
    self.view.layer.cornerRadius = 0.5
    self.view.layer.borderColor = UIColor.lightGray.cgColor
    
    self.segmentControlOut.frame = CGRect(x: self.segmentControlOut.frame.origin.x, y: self.segmentControlOut.frame.origin.y, width: self.segmentControlOut.frame.size.width, height: 50);
    self.segmentControlOut.layer.cornerRadius = -1.0
    self.segmentControlOut.layer.masksToBounds = true
    self.segmentControlOut.tintColor = UIColor.white
    self.segmentControlOut.layer.borderWidth = 1.0
    self.segmentControlOut.layer.borderColor = UIColor.lightGray.cgColor
    self.segmentControlOut.setDividerImage(imageWithColor(color: UIColor.lightGray), forLeftSegmentState: [], rightSegmentState: [], barMetrics: .default)
    
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(KeyboardViewController.handleLongPress(_:)))
    longPress.minimumPressDuration = 0.5
    longPress.numberOfTouchesRequired = 1
    longPress.allowableMovement = 0.5
    self.segmentControlOut.addGestureRecognizer(longPress)
    
    //    if KeyboardViewController.hasFullAccess() {
    //      self.toastView.makeToast("Keyboard has full access")
    //    }
    
  }
  
  func didDoubleTapCollectionView(_ gestureRecognizer: UITapGestureRecognizer) {

//    let tapLocation = gestureRecognizer.location(in: collectionView)
//    let indexPath : IndexPath = collectionView.indexPathForItem(at: tapLocation)!
//    let imageName = currentImages[indexPath.row + indexPath.section]
    let url = URL(string: "https://www.chippmoji.com")!
    openUrl(url: url)

  }
  
  func openUrl(url: URL?) {
    let selector = sel_registerName("openURL:")
    var responder = self as UIResponder?
    while let r = responder, !r.responds(to: selector) {
      responder = r.next
    }
    _ = responder?.perform(selector, with: url)
  }
  
  func handleLongPress(_ gestureRecognizer: UIGestureRecognizer) {
    let point = gestureRecognizer.location(in: segmentControlOut)
    let segmentSize = segmentControlOut.bounds.size.width / CGFloat(segmentControlOut.numberOfSegments)
    let touchedSegment = Int(point.x / segmentSize)
    if touchedSegment == 5 {
      textDocumentProxy.deleteBackward()
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if keyboardView == nil {
      return
    }
    if collectionView == nil {
      let rect = CGRect(origin: CGPoint(x: 10, y: 0), size: CGSize(width: self.view.frame.width - 30, height: 170))
      let flowLayout = EmojiCollectionViewFlowLayout()
      flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
      flowLayout.itemSize = CGSize(width: 70, height: 70)
      collectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
      collectionView.backgroundColor = UIColor.white
      collectionView.delegate = self
      collectionView.register(UINib(nibName: "EmojiCell", bundle: nil), forCellWithReuseIdentifier: KeyboardViewController.kReuseIdentifier)
      collectionView.dataSource = self
      collectionView.isPagingEnabled = false
      collectionView.bounces = false
      
//      let doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(KeyboardViewController.didDoubleTapCollectionView(_:)))
//      doubleTapGesture.numberOfTapsRequired = 2  // add double tap
//      self.collectionView.addGestureRecognizer(doubleTapGesture)
      
      self.view.addSubview(collectionView)
      toastView = UIView(frame: collectionView.frame)
      toastView.backgroundColor = UIColor.clear
      toastView.isUserInteractionEnabled = false
      self.view.addSubview(toastView)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func textWillChange(_ textInput: UITextInput?) {
  }
  
  override func textDidChange(_ textInput: UITextInput?) {
    
  }
  
  func lipsEmojiButtonClicked() {
    currentImages = EmojiDefs.imageForCategory(EmojiDefs.Categories.lips)
    collectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                at: .left,
                                animated: false)
    imageDir = "images/lips"
    collectionView.reloadData()
  }
  
  func speechEmojiButtonClicked() {
    currentImages = EmojiDefs.imageForCategory(EmojiDefs.Categories.speech)
    collectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                at: .left,
                                animated: false)
    imageDir = "images/speeches"
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
    collectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                at: .left,
                                animated: false)
    imageDir = "images/dancers"
    collectionView.reloadData()
  }
  
  
  func nextKeyboardButtonClicked() {
    super.advanceToNextInputMode()
  }
  
  func shareButtonClicked() {
    let url = "http://www.chippmoji.com"
    self.textDocumentProxy.insertText("Take a look at Chippmoji! \(url)")
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return currentImages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: KeyboardViewController.kReuseIdentifier, for: indexPath)as! EmojiCell
    cell.imageView?.image = nil
    let name = self.currentImages[indexPath.row + indexPath.section]
    if name.components(separatedBy: ".").last == "gif" {
      if let val = imageCache.object(forKey: name as NSString) as? UIImage {
        cell.imageView?.image = val
      } else {
        if let localGifURL = Bundle.main.url(forResource: name.components(separatedBy: ".").first, withExtension: "gif", subdirectory: self.imageDir){
          DispatchQueue.global(qos: .userInteractive).async(execute: { () -> Void in
            let image = UIImage.gif(url: localGifURL)
            DispatchQueue.main.async(execute: { () -> Void in
              cell.imageView?.image = image
              self.imageCache.setObject(image!, forKey: name as NSString)
            })
          })
        }
      }
    } else {
      if let filePath = Bundle.main.path(forResource: name.components(separatedBy: ".").first, ofType: "png", inDirectory: imageDir) {
        DispatchQueue.main.async {
          let uiimage = self.scaleImageDown(UIImage(contentsOfFile: filePath)!, scale: 0.5)
          cell.imageView?.image = uiimage
        }
        
      }
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! EmojiCell
    cell.backgroundColor = UIColor.gray
  }
  
  func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! EmojiCell
    cell.backgroundColor = UIColor.white
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let imageName = currentImages[indexPath.row + indexPath.section]
    var uiimage : UIImage!
    if imageName.components(separatedBy: ".").last == "gif" {
      if let filePath = Bundle.main.path(forResource: imageName.components(separatedBy: ".").first, ofType: "gif", inDirectory: imageDir) {
        let gifData = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        //UIPasteboard.general.setData(gifData!, forPasteboardType: "com.compuserve.gif")
        //UIPasteboard.general.items = ([[kUTTypeGIF as String : gifData!], [kUTTypeURL as String : url]])
        UIPasteboard.general.items = [[kUTTypeGIF as String : gifData!]]
        self.toastView.makeToast("Chippmoji gif copied. Now paste it!")
      }
    } else {
      if let filePath = Bundle.main.path(forResource: imageName.components(separatedBy: ".").first, ofType: "png", inDirectory: imageDir) {
        uiimage = UIImage(contentsOfFile: filePath)!
        //UIPasteboard.general.image = scaleImageDown(uiimage, scale: 0.5)
//         UIPasteboard.general.items = [[kUTTypePNG as String : scaleImageDown(uiimage, scale: 0.5)], [kUTTypeURL as String : url]]
         UIPasteboard.general.items = [[kUTTypePNG as String : scaleImageDown(uiimage, scale: 0.7)]]
        self.toastView.makeToast("Chippmoji copied. Now paste it!")
      }
    }
    
    
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
  
  func imageWithColor(color: UIColor) -> UIImage {
    let rect = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 1, height: 1))
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()!
    context.setFillColor(color.cgColor)
    context.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if imageDir == "images/dancers" {
      let itemsPerRow:CGFloat = 2.5
      let hardCodedPadding:CGFloat = 5
      let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
      return CGSize(width: itemWidth, height: 125)
      //return CGSize(width: 125, height: 125)
    } else {
      let itemsPerRow:CGFloat = 3.5
      let hardCodedPadding:CGFloat = 5
      let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
      return CGSize(width: itemWidth, height: 75)
    }
  }
  
}
