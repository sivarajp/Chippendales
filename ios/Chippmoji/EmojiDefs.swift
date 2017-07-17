//
//  EmojiDef.swift
//  Chippendales
//
//  Created by Sivaraj-Pasumalaithevan (Contractor) on 6/15/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation
import UIKit

struct EmojiDefs {
  enum Categories { case lips, speech, dance }
  
  static func imageForCategory(_ category: Categories) -> [String] {
    switch(category) {
    case .lips:
      return lipsImages
    case .speech:
      return speechImages
    case .dance:
      return danceImages
    }
  }
  
  static func loadGif(name: String, imageDir: String) -> UIImage? {
    if let localGifURL = Bundle.main.url(forResource: name.components(separatedBy: ".").first, withExtension: "gif", subdirectory: imageDir){
      print ("Inside before Gif image")
      return UIImage.gif(url: localGifURL)
    }
    return nil
  }
  
  static let someDict:[String : UIImage] = [
              "toolit480x480.gif" : loadGif(name: "toolit480x480.gif", imageDir: "images/speeches")!,
              "truthdare480x480.gif" : loadGif(name: "truthdare480x480.gif", imageDir: "images/speeches")!,
              "Champagne.gif" : loadGif(name: "Champagne.gif", imageDir: "images/dancers")!,
              "Cheers.gif" : loadGif(name: "Cheers.gif", imageDir: "images/dancers")!,
              "IHeartU.gif" : loadGif(name: "IHeartU.gif", imageDir: "images/dancers")!,
              "Recoverymode.gif" : loadGif(name: "Recoverymode.gif", imageDir: "images/dancers")!,
              "StraightChillin.gif" : loadGif(name: "StraightChillin.gif", imageDir: "images/dancers")!,
              "ThanksNew.gif" : loadGif(name: "ThanksNew.gif", imageDir: "images/dancers")!,
              "TurnUp1.gif" : loadGif(name: "TurnUp1.gif", imageDir: "images/dancers")!,
              "SmokinHot.gif" : loadGif(name: "SmokinHot.gif", imageDir: "images/dancers")!
              ]
  
  static let speechImages: [String] = [
    "basic480",
    "bestnightever",
    "boujee480",
    "bridindirty480",
    "cancelled480",
    "cheers480",
    "datd480",
    "dbrain480",
    "dmind480",
    "done480",
    "extra480",
    "faded480",
    "fam480",
    "getlitdietrying",
    "ghosting480",
    "gucci480",
    "hecouldgetit480",
    "hubbymaterial480",
    "hundop480",
    "icanteven480",
    "lastfling480",
    "lit480",
    "live480",
    "obvi480",
    "onfleek480",
    "onpoint480",
    "racthet480",
    "redick480",
    "salty480",
    "savage480",
    "slay480",
    "squad480",
    "sus480",
    "talkdirty480",
    "thirsty480",
    "thot480",
    "toolit480x480.gif",
    "trolling480",
    "truthdare480x480.gif",
    "turnt480",
    "wifematerial480",
    "woke480",
    "zerochill480",
  ]
  
  static let danceImages: [String] = [
    "Banana",
    "BirthdayTiara",
    "BlingRing",
    "BrideSash",
    "Cactus",
    "Champagne.gif",
    "Cheers.gif",
    "CherryMouth",
    "Condom",
    "CornDog",
    "Dirty30",
    "Handcuffs",
    "HardMenSign",
    "HellaFine",
    "IHeartU.gif",
    "Mushroom",
    "popsicle",
    "Recoverymode.gif",
    "SaddleUp",
    "SmokinHot.gif",
    "snake",
    "StraightChillin.gif",
    "Sucker",
    "ThanksNew.gif",
    "TurnUp1.gif",
    "VitaminD",
    "Wine"
  ]
  
  static let lipsImages: [String] = [
    "Banana"
      ]
}
