# [flutter_printer](https://github.com/lisen87/flutter_printer.git)

Handling the original flutter print method incomplete, no json format problem.This is a pure dart language development package

> Supported  Platforms
> * Android
> * iOS

## How to Use

```yaml
# add this line to your dependencies
flutter_printer: ^0.0.3
```

```dart
import 'flutter_printer.dart';
```

```dart
Printer.printMapJsonLog(dynamic,);
```
Printer property | description
--------|------------
dynamic | List or Map or String
state | State
lineNum | Printed line position