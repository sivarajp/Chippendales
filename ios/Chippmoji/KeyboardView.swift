//
//  KeyboardView.swift
//  Chippendales
//
//  Created by Sivaraj-Pasumalaithevan (Contractor) on 6/15/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import UIKit

protocol KeyboardActionHandler {
  func deleteButtonClicked()
  func nextKeyboardButtonClicked()
  func lipsEmojiButtonClicked()
  func speechEmojiButtonClicked()
  func danceEmojiButtonClicked()
  func shareButtonClicked()
  
}

class KeyboardView: UIView {
  
  var delegate: KeyboardActionHandler?
  
  @IBOutlet weak var currentButton: UIButton!
  
  @IBAction func changeKeyboard(_ sender: UIButton) {
    delegate?.nextKeyboardButtonClicked()
  }
  
  @IBAction func lipsEmoji(_ sender: UIButton) {
    selectButton(button: sender)
    delegate?.lipsEmojiButtonClicked()
  }
  
  
  @IBAction func speechEmoji(_ sender: UIButton) {
    selectButton(button: sender)
    delegate?.speechEmojiButtonClicked()
  }
  
  
  @IBAction func danceEmoji(_ sender: UIButton) {
    selectButton(button: sender)
    delegate?.danceEmojiButtonClicked()
  }
  
  
  @IBAction func shareButtonClicked(_ sender: UIButton) {
    delegate?.shareButtonClicked()
  }
  
  @IBAction func deleteText(_ sender: UIButton) {
    delegate?.deleteButtonClicked()
  }
  
  
  func selectButton(button: UIButton) {
    if button === currentButton { return }
    button.isSelected = true
    currentButton.isSelected = false
    currentButton = button
  }
}
