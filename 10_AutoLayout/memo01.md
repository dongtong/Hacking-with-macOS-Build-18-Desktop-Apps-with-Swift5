# Project6
## Part1

![image](https://i.imgur.com/VhYKLiM.png)

- VFLは下記を参考にすると意味をつかみやすいか。
    - [【swift】コードでAutoLayout その1 \- Visual Format Language \- tanihiro\.log](http://tanihiro.hatenablog.com/entry/2016/02/18/235912)
    - [VFLを使ってみよう](https://blog.personal-factory.com/2016/01/16/use-visual-format-language-with-auto-layout/)
    - [constraints\(withVisualFormat:options:metrics:views:\)](https://developer.apple.com/documentation/uikit/nslayoutconstraint/1526944-constraints)
    
## Part2

- 説明だけでは理解が厳しかったので、下記記事で軽く補填した。
    - [\[Swift 3\.0\]NSLayoutAnchorを用いたコードによるAuto Layout \- Qiita](https://qiita.com/shindooo/items/36d2e8bf9d8ba3fa4ed5)

![image](https://i.imgur.com/9Ws8eum.png)

## Part3
- StackViewの話
- [setContentHuggingPriority\(\_:for:\)](https://developer.apple.com/documentation/appkit/nsview/1526937-setcontenthuggingpriority)

## Part4
- GridViewの話
- 結合の辺りは下記のようなイメージ

![image](https://i.imgur.com/7cyhE5p.png)

![image](https://i.imgur.com/IoQfBBb.png)


```swift
gridView.row(at: 0).mergeCells(in: NSRange(location: 0, length: 4))
gridView.row(at: 1).mergeCells(in: NSRange(location: 0, length: 2))
gridView.row(at: 1).mergeCells(in: NSRange(location: 2, length: 2))
gridView.row(at: 3).mergeCells(in: NSRange(location: 0, length: 2))
gridView.row(at: 3).mergeCells(in: NSRange(location: 2, length: 2))
gridView.row(at: 4).mergeCells(in: NSRange(location: 0, length: 4))
gridView.row(at: 0).yPlacement = .center
gridView.row(at: 1).yPlacement = .center
gridView.row(at: 2).yPlacement = .center
gridView.row(at: 3).yPlacement = .center
gridView.row(at: 4).yPlacement = .center
gridView.column(at: 0).xPlacement = .center
gridView.column(at: 1).xPlacement = .center
gridView.column(at: 2).xPlacement = .center
gridView.column(at: 3).xPlacement = .center
```
