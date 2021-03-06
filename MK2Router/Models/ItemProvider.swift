//
//  ItemProvider.swift
//  MK2Router
//
//  Created by k2o on 2016/05/14.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

class ItemProvider {
    static let shared: ItemProvider = ItemProvider()
    
    fileprivate init() {
    }
    
    func getAllItems(_ handler: ([Item]) -> Void) {
        let items = [
            self.itemForID(1, imageQuarity: "small"),
            self.itemForID(2, imageQuarity: "small"),
            self.itemForID(3, imageQuarity: "small"),
            self.itemForID(4, imageQuarity: "small"),
            self.itemForID(5, imageQuarity: "small")
        ]
        
        handler(items)
    }

    func getItems(keyword: String, handler: ([Item]) -> Void) {
        self.getAllItems { (items) in
            if keyword.isEmpty {
                handler(items)
            } else {
                let matchItems = items.filter({ (item) -> Bool in
                    return item.title.contains(keyword) || item.detail.contains(keyword)
                })
                
                handler(matchItems)
            }
        }
    }
    
    func getAllItemIDs(_ handler: ([Int]) -> Void) {
        self.getAllItems { (items) in
            let itemIDs = items.map { $0.ID }
            handler(itemIDs)
        }
    }
    
    func getItemDetail(_ ID: Int, handler: (Item) -> Void) {
        let item = self.itemForID(ID, imageQuarity: "large")
        
        handler(item)
    }
    
    // MARK: - 
    
    fileprivate func itemForID(_ ID: Int, imageQuarity: String) -> Item {
        guard let fixture = self.fixtures[ID] else {
            fatalError()
        }
        
        guard
            let title = fixture["title"],
            let detail = fixture["detail"],
            let imagePrefix = fixture["image_prefix"]
        else {
            fatalError()
        }
        
        return Item(ID: ID, title: title, detail: detail, image: UIImage(named: "\(imagePrefix)_\(imageQuarity)"))
    }
    
    fileprivate let fixtures = [
        1: [
            "title": "弁当",
            "detail": "弁当（辨當、べんとう）とは、携帯できるようにした食糧のうち、食事に相当するものである。家庭で作る手作り弁当と、市販される商品としての弁当の2種に大別される。後者を「買い弁」ということがある[1]。海外でも'Bento'として日本式の弁当箱とともに普及し始めた。",
            "image_prefix": "bento"
        ],
        2: [
            "title": "夕焼け",
            "detail": "夕焼け（ゆうやけ）は、日没の頃、西の地平線に近い空が赤く見える現象のこと。夕焼けの状態の空を夕焼け空、夕焼けで赤く染まった雲を「夕焼け雲」と称する。日の出の頃に東の空が同様に見えるのは朝焼け（あさやけ）という。",
            "image_prefix": "evening"
        ],
        3: [
            "title": "クラゲ",
            "detail": "クラゲ（水母、海月、水月）は、刺胞動物門に属する動物のうち、淡水または海水中に生息し浮遊生活をする種の総称。体がゼラチン質で、普通は触手を持って捕食生活をしている。また、それに似たものもそう呼ぶこともある。",
            "image_prefix": "jellyfish"
        ],
        4: [
            "title": "バラ",
            "detail": "バラ（薔薇）は、バラ科バラ属の総称である[1][2][3]。あるいは、そのうち特に園芸種（園芸バラ・栽培バラ）を総称する[1]。ここでは、後者の園芸バラ・栽培バラを扱うこととする。",
            "image_prefix": "rose"
        ],
        5: [
            "title": "塔",
            "detail": "塔（とう）とは、接地面積に比較して著しく高い構造物のことである。",
            "image_prefix": "tower"
        ]
    ]
}
