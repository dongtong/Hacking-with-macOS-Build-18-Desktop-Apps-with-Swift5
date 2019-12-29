//: Playground - noun: a place where people can play

import UIKit

var favoriteTVShows = ["Red Dwarf", "Blackadder", "Fawlty Towers", "Red Dwarf"]
var favoriteCounts = [String: Int]()

for show in favoriteTVShows {
  favoriteCounts[show, default: 0] += 1
}
print(favoriteCounts)
