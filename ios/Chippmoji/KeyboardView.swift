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
}

class KeyboardView: UIView {
  
  var delegate: KeyboardActionHandler?
  
  
    @IBAction func changeKeyboard(_ sender: UIButton) {
        delegate?.nextKeyboardButtonClicked()
    }
  
    @IBAction func lipsEmoji(_ sender: UIButton) {
      delegate?.lipsEmojiButtonClicked()
    }
  
    
    @IBAction func speechEmoji(_ sender: UIButton) {
      delegate?.speechEmojiButtonClicked()
    }
    
    
    @IBAction func danceEmoji(_ sender: UIButton) {
      delegate?.danceEmojiButtonClicked()
    }
    
        
  @IBAction func shareApp(_ sender: UIButton) {
  
  }
  
  @IBAction func deleteText(_ sender: UIButton) {
    delegate?.deleteButtonClicked()
  }
    
}
