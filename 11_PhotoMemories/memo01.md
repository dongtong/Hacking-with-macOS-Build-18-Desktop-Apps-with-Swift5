## Part3
- `SlideMark`が下記の場所に作られてしまう。
- [SandBoxが原因だそう。](https://www.udemy.com/course/hacking-with-macos-and-swift4/learn/lecture/8304570#questions/3649356)

```sh
/Users/<UserName>/Library/Containers/com.gmail.ikeh1024.Project7/Data/Documents/SlideMark
```

- OFFにすると期待通りの動作

![image](https://i.imgur.com/fgkeRha.png)

```sh
/Users/hirokiikeuchi/Documents/SlideMark
```

## Part4
## Part4
- また変わっているところがある。
- 適宜サンプルコードを参照する

```swift
collectionView.registerForDraggedTypes([NSPasteboard.PasteboardType(kUTTypeURL as String)])
```
