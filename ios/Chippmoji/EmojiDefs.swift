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
  //Converting during runtime slows the perf. Did static
  /*static let someDict:[String : UIImage] = [
              "toolit480x480.gif" : loadGif(name: "toolit480x480.gif", imageDir: "images/speeches")!,
              "truthdare480x480.gif" : loadGif(name: "truthdare480x480.gif", imageDir: "images/speeches")!,
              "Blessed.gif" : loadGif(name: "Blessed.gif", imageDir: "images/dancers")!,
              "BlockingOut.gif" : loadGif(name: "BlockingOut.gif", imageDir: "images/dancers")!,
              "DealWithIt.gif" : loadGif(name: "DealWithIt.gif", imageDir: "images/dancers")!,
              "DropIt.gif" : loadGif(name: "DropIt.gif", imageDir: "images/dancers")!,
              "HellYeah.gif" : loadGif(name: "HellYeah.gif", imageDir: "images/dancers")!,
              "HeyGirl.gif" : loadGif(name: "HeyGirl.gif", imageDir: "images/dancers")!,
              "KissMyAss.gif" : loadGif(name: "KissMyAss.gif", imageDir: "images/dancers")!,
              "SayWhat.gif" : loadGif(name: "SayWhat.gif", imageDir: "images/dancers")!,
              "SmokinHot.gif" : loadGif(name: "SmokinHot.gif", imageDir: "images/dancers")!,
              "StraightChillin.gif" : loadGif(name: "StraightChillin.gif", imageDir: "images/dancers")!,
              "ThanksNew.gif" : loadGif(name: "ThanksNew.gif", imageDir: "images/dancers")!,
              "TurnUp1.gif" : loadGif(name: "TurnUp1.gif", imageDir: "images/dancers")!,
              "Champagne.gif" : loadGif(name: "Champagne.gif", imageDir: "images/lips")!,
              "Cheers.gif" : loadGif(name: "Cheers.gif", imageDir: "images/lips")!,
              "IHeartU.gif" : loadGif(name: "IHeartU.gif", imageDir: "images/lips")!,
              "Recoverymode.gif" : loadGif(name: "Recoverymode.gif", imageDir: "images/lips")!,
              ]
  */
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
    "Blessed.gif",
    "BlockingOut.gif",
    "DealWithIt.gif",
    "HellaFine",
    "HellYeah.gif",
    "HeyGirl.gif",
    "KissMyAss.gif",
    "SaddleUp",
    "SayWhat.gif",
    "SmokinHot.gif",
    "StraightChillin.gif",
    "ThanksNew.gif",
    "TurnUp1.gif",  ]
  
  static let lipsImages: [String] = [
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
    "Fire",
    "Handcuffs",
    "HardMenSign",
    "IHeartU.gif",
    "lips",
    "popsicle",
    "Recoverymode.gif",
    "snake",
    "Sucker",
    "VitaminD",
    "Wine",
    ]
}
