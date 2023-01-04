# [flutter_printer](https://github.com/lisen87/flutter_printer.git)

处理原始的flutter打印方法不完整，没有json格式的问题。
这是一个纯dart开发包，可以打印出完整的json格式数据并带有打印位置信息，可快速定位到调用Printer的文件。

Handling the original flutter print method incomplete, no json format problem.This is a pure dart language development package

> Supported  Platforms
> * Android
> * iOS

## How to Use

```yaml
# add this line to your dependencies
flutter_printer: ^2.0.3
```

```dart
import 'package:flutter_printer/flutter_printer.dart';
```

```dart

Printer.info('info log');

Printer.debug('debug log');

Printer.warn('warn log');

Printer.error('error log');

Printer.printMapJsonLog(list,stackTrace: StackTrace.current,);

or

Printer.printMapJsonLog(map,stackTrace: StackTrace.current,prefix: "我是前缀:",);
```

```dart

配置颜色（可选）
Printer.config = ColorConfig(
      infoRgb: xtermRgb(Colors.red.red, Colors.red.green, Colors.red.blue),
      debugRgb: xtermRgb(Colors.orange.red, Colors.orange.green, Colors.orange.blue),
      warnRgb: xtermRgb(Colors.brown.red, Colors.brown.green, Colors.brown.blue),
      errorRgb: xtermRgb(Colors.teal.red, Colors.teal.green, Colors.teal.blue),
    );
```

```dart
当你发布的时候请关闭数据打印
Please turn off data printing when you publish it.

Printer.enable = false;

```

![](https://github.com/lisen87/flutter_printer/blob/master/screenshots/printer1.png)

![](https://gitee.com/lisen453354858/interface/raw/master/printer1.png)

![](https://github.com/lisen87/flutter_printer/blob/master/screenshots/xterm256.png)

Printer property | description
--------|------------
dynamic | List or Map or String
stackTrace | StackTrace.current(固定写法/Fixed writing)
prefix | prefix
