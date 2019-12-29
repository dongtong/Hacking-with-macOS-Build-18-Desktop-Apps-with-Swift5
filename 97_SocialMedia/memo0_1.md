- 下記、mouseDownとmouseUpのときのマウスの座標が異なるのでエラーメッセージがでているから、mouseDownのときの座標を採用する、ということ？

```swift
shareButton.sendAction(on: .leftMouseDown)
```

- responderChainは可能な限り低いほう（下流）に書くのが良い（今回だとWindowController、NSButtonが源流）