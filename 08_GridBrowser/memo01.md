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

