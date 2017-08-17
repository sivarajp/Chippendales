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
      return UIImage.gif(url: localGifURL)
    }
    return nil
  }
  
  static let emojilinks = ["116_Tourticket": "http://www.chippendales.com/touring-show" ,
                      "106_Treat" : "https://boutique.chippendales.com",
                      "101_Vegas" : "http://www.chippendales.com/tickets"
                      ]

  static let speechImages: [String] = listFilesFromDocumentsFolder(folderPath: "images/speeches")!
  
  static let danceImages: [String] = listFilesFromDocumentsFolder(folderPath: "images/dancers")!
  
  static let lipsImages: [String] = listFilesFromDocumentsFolder(folderPath: "images/lips")!
  
  static func listFilesFromDocumentsFolder(folderPath: String)->[String]?{
    var imageNames = [String]()
    let docsPath = Bundle.main.resourcePath! + "/" + folderPath
    let fileManager = FileManager.default
    do {
       imageNames = try fileManager.contentsOfDirectory(atPath: docsPath)
    } catch {
      print(error)
    }
    return imageNames
  }
}
