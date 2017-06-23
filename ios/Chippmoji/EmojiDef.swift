//
//  EmojiDef.swift
//  Chippendales
//
//  Created by Sivaraj-Pasumalaithevan (Contractor) on 6/15/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation

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
  
  static let lipsImages: [String] = [
    "basic480",
    "cheers480",
    "extra480",
    "gucci480",
    "lastfling480",
    "onpoint480",
    "slay480",
    "thot480",
    "wifematerial480",
    "bestnightever",
    "datd480",
    "faded480",
    "hecouldgetit480",
    "lit480",
    "racthet480",
    "squad480",
    "woke480",
    "boujee480",
    "dbrain480",
    "fam480",
    "hubbymaterial480",
    "live480",
    "redick480",
    "sus480",
    "trolling480",
    "zerochill480",
    "bridindirty480",
    "dmind480",
    "getlitdietrying",
    "hundop480",
    "obvi480",
    "salty480",
    "talkdirty480",
    "cancelled480",
    "done480",
    "ghosting480",
    "icanteven480",
    "onfleek480",
    "savage480",
    "thirsty480",
    "turnt480"
  ]
  
  static let danceImages: [String] = [
    "cheers480",
    "man.gif",
    "truthdare480x480.gif"
  ]
  
  static let speechImages: [String] = [
    "datd480",
    "man.gif",
    "toolit480x480.gif"
  ]
}
