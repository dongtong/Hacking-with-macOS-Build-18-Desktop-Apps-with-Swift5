# Part2
- Proxyの`animator()`を使う限り自動でAutoになると。サンプルコードの記述は意味ないか？
- falseにするとなんとなくアニメーションしてる気はする
>[allowsImplicitAnimation](https://developer.apple.com/documentation/appkit/nsanimationcontext/1525870-allowsimplicitanimation)
> Using the animator() proxy will automatically set allowsImplicitAnimation to true. When true, other properties can implicitly animate along with the initially changed property.

# Part3

- アニメーション後に下記の処理をするようなStackOverFlowの記述があるが間違い
- 実態がアニメーション後の状態になるように処理をしないといけません
    - [コメント参照 -> iOSアプリ開発でアニメーションするなら押さえておきたい基礎 \- Qiita](https://qiita.com/hachinobu/items/57d4c305c907805b4a53)

```swift
animateStrokeEnd.removedOnCompletion = false
animateStrokeEnd.fillMode = kCAFillModeForwards
```

- 今回の例だと実際に`opacity = 0`としている

```swift
case 7:
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.fromValue = 1
    animation.toValue = 0
    imageView.layer?.opacity = 0
    imageView.layer?.add(animation, forKey: nil)
```
