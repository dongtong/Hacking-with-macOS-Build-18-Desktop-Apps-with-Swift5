## SegmentedControlのスタイル設定
- [NSSegmentedControl\.Style](https://developer.apple.com/documentation/appkit/nssegmentedcontrol/style)
- `separated`はSafariのように少し別れている

> case separated
> The segments in the control are displayed very close to each other but not touching. For example, Safari in macOS 10.10 and later uses this style for the previous and next page segmented control.

![image](https://i.imgur.com/lnficJr.png)

- 今回はくっついている`rounded`を使用する

>case rounded
The control is displayed using the rounded style.



## AutoLayout

- `rows.translatesAutoresizingMaskIntoConstraints = false`
    - AutoLayoutと設定がバッティングしてしまうのでOFFにする

>[Auto Layoutをコードから使おう](https://blog.personal-factory.com/2016/01/11/make-auto-layout-via-code/)
> 生成したビューのプロパティにtranslatesAutoresizingMaskIntoConstraintsというものがあります。
> これをオフにします。
> このプロパティはAuto Layout以前に使われていた、Autosizingのレイアウトの仕組みをAuto Layoutに変換するかどうかを設定するフラグです。
> デフォルトではオンになっていて、オンのままだと期待通りのAuto Layout設定ができない場合があるのでオフにします。    

![image](https://i.imgur.com/uHqYe8F.png)

- `wantsLayer`はiOSと違ってデフォルトでOFFになっている
- ACTIVE状態を示す青枠を描画するために`YES`にしているとか

![image](https://i.imgur.com/vUJsskI.png)

![image](https://i.imgur.com/N7I4Orn.png)

- コードによるAutoLayout制約は下記が分かりやすかった。
    - [\[Swift 3\.0\]NSLayoutAnchorを用いたコードによるAuto Layout \- Qiita](https://qiita.com/shindooo/items/36d2e8bf9d8ba3fa4ed5)

```swift
rows.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
```

- StackViewの入れ子はこういう構成
- 説明だけじゃ正直わからないけれど、コード見ればなんとなく分かるな。
- コード内のコメントにいくつか日本語で補足した

![image](https://i.imgur.com/i1DeOmt.png)

- CALayer、core animationはCocoaより低層な`CGColor`を使っている
- これは`NSColor`簡単に変換できるよ

![image](https://i.imgur.com/yjFYciw.png)

- 全体的に言えることだが、`delegate`を`extension`に分けていないので見通しが悪い。
- 好みで分けたほうが見返すときに便利そうである。
- あとTouchBarあたりの説明が口頭だけになっているので、もう一度見返すことが必要そう。