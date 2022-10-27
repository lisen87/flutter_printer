class Printer {
  ///是否开启打印 Whether to turn on printing
  static bool enable = true;

  static ColorConfig config  = ColorConfig();

  ///Print map or list, etc.
  ///stackTrace stackTrace
  ///prefix prefix
  ///xtermRgb 0-255
  ///可已打印任意数据，stackTrace不为null时可显示出使用Printer的位置，prefix 打印数据前缀
  ///Any data can be printed. When the stackTrace is not null, the location where the printer is used can be displayed. The prefix prints the data prefix.
  static void printMapJsonLog(dynamic content,
      {StackTrace? stackTrace, String? prefix,int? xtermRgb}) {
    if (enable) {
      if(xtermRgb == null){
        xtermRgb = config.infoRgb;
      }
      _warpMapJson(content, stackTrace: stackTrace, prefix: prefix,xtermRgb:xtermRgb);
    }
  }

  static void info(dynamic content,
      {StackTrace? stackTrace, String? prefix,int? xtermRgb}){
    if(xtermRgb == null){
      xtermRgb = config.infoRgb;
    }
    printMapJsonLog(content,stackTrace: stackTrace,prefix: prefix,xtermRgb: xtermRgb);
  }

  static void debug(dynamic content,
      {StackTrace? stackTrace, String? prefix,int? xtermRgb}){
    if(xtermRgb == null){
      xtermRgb = config.debugRgb;
    }
    printMapJsonLog(content,stackTrace: stackTrace,prefix: prefix,xtermRgb: xtermRgb);
  }

  static void warn(dynamic content,
      {StackTrace? stackTrace, String? prefix,int? xtermRgb}){
    if(xtermRgb == null){
      xtermRgb = config.warnRgb;
    }
    printMapJsonLog(content,stackTrace: stackTrace,prefix: prefix,xtermRgb: xtermRgb);
  }

  static void error(dynamic content,
      {StackTrace? stackTrace, String? prefix,int? xtermRgb}){
    if(xtermRgb == null){
      xtermRgb = config.errorRgb;
    }
    printMapJsonLog(content,stackTrace: stackTrace,prefix: prefix,xtermRgb: xtermRgb);
  }

  ///With indentation
  static void _warpMapJson(dynamic msg,
      {StackTrace? stackTrace, String? prefix,int? xtermRgb = 10}) {
    String top =
        "┌------------------------------------------------------------------------------------------------------------------------------------------┐";
    String bottom =
        "└------------------------------------------------------------------------------------------------------------------------------------------┘";

    ///current Widget ---->
    if (stackTrace != null) {
      String stackInfo = stackTrace.toString().split("#1")[0].toString();
      stackInfo = stackInfo.substring(
          stackInfo.indexOf("(") + 1, stackInfo.lastIndexOf(")"));
      top = top.replaceRange(10, stackInfo.length, stackInfo);
      bottom = bottom.replaceRange(10, stackInfo.length, stackInfo);
    }
    _print(top,xtermRgb);
    if (prefix != null && prefix.trim().length != 0) {
      _print('|\t' + prefix,xtermRgb);
    }
    _genReadableJson(msg,xtermRgb);

    _print(bottom,xtermRgb);
  }

  ///Format json data by type
  static void _genReadableJson(dynamic data,int? xtermRgb) {
    if (data is List) {
      _resolveList(1, data, false,xtermRgb);
    } else if (data is Map) {
      _resolveMap(1, data, false,xtermRgb);
    } else {
      if(data is String){
        _splitStr(1,data,xtermRgb);
      }else{
        _print('|\t'+ data.toString(),xtermRgb);
      }
    }
  }

  static _splitStr(int space ,String? data,int? xtermRgb){
    if(data != null && data.contains('\n')){
      StringBuffer stringBuffer = StringBuffer();
      List<String> list = data.split(RegExp(r'\n'));
      stringBuffer.write('|');
      for (int i = 0; i < space ; i++) {
        stringBuffer.write('\t');
      }
      list.forEach((str){
        _splitLineStr(space,str,xtermRgb);
      });
    }else{
      _splitLineStr(space,data,xtermRgb);
    }
  }

  static _splitLineStr(int space ,String? data,int? xtermRgb) {
    StringBuffer stringBuffer = StringBuffer();
    int limit = 150;
    if (data != null && data.length > limit) {
      int count = data.length ~/ limit;
      stringBuffer.write('|');
      for (int i = 0; i < space; i++) {
        stringBuffer.write('\t');
      }
      for (int i = 0; i < count; i++) {
        if (i == count - 1) {
          _print(
              stringBuffer.toString() + data.substring(i * limit, data.length),xtermRgb);
        } else {
          _print(stringBuffer.toString() +
              data.substring(i * limit, i * limit + limit),xtermRgb);
        }
      }
    }else{
      _print('|\t'+ data!,xtermRgb);
    }
  }

  ///Format json
  static void _resolveMap(int space, Map<dynamic, dynamic> data, bool isLast,int? xtermRgb) {
    int index = 0;
    space++;
    StringBuffer stringBufferStart = new StringBuffer();
    stringBufferStart.write('|');
    for (int i = 0; i < space; i++) {
      stringBufferStart.write('\t');
    }
    // stringBufferStart.write("{\n");
    stringBufferStart.write('{');
    _print(stringBufferStart.toString(),xtermRgb);
    data.forEach((key, value) {
      index++;
      StringBuffer stringBuffer = new StringBuffer();
      stringBuffer.write('|');
      for (int i = 0; i < space + 1; i++) {
        stringBuffer.write('\t');
      }
      stringBuffer.write('\"' + key + '\"');
      stringBuffer.write(' : ');
      if (value is Map) {
        _print(stringBuffer.toString(),xtermRgb);
        _resolveMap(space + 1, value, index != data.length,xtermRgb);
      } else if (value is List) {
        if (value.length == 0) {
          stringBuffer.write('[]');
          if(index != data.length){
            stringBuffer.write(',');
          }
          _print(stringBuffer.toString(),xtermRgb);
        } else {
          _print(stringBuffer.toString(),xtermRgb);
          _resolveList(space + 1, value, index != data.length,xtermRgb);
        }
      } else {
        if (value == null) {
          stringBuffer.write(null);
        } else {
          if (value is String) {
            stringBuffer.write('\"' + value.toString() + '\"');
          } else {
            stringBuffer.write(value);
          }
        }
        if (index != data.length) {
          stringBuffer.write(',');
        }
        // stringBuffer.write("\n");
        _print(stringBuffer.toString(),xtermRgb);
      }
    });

    StringBuffer stringBufferEnd = new StringBuffer();
    stringBufferEnd.write('|');
    for (int i = 0; i < space; i++) {
      stringBufferEnd.write('\t');
    }
    stringBufferEnd.write('}');
    if (isLast) {
      stringBufferEnd.write(',');
    }

    _print(stringBufferEnd.toString(),xtermRgb);
  }

  ///Format list json
  static void _resolveList(int space, List? list, bool isLast,int? xtermRgb) {
    int index = 0;
    space++;
    StringBuffer stringBufferStart = new StringBuffer();
    stringBufferStart.write('|');
    for (int i = 0; i < space; i++) {
      stringBufferStart.write('\t');
    }

    if (list == null) {
      stringBufferStart.write(null);
      _print(stringBufferStart.toString(),xtermRgb);
    } else {
      if (list.length == 0) {
        stringBufferStart.write('[]');
        if (isLast) {
          stringBufferStart.write(',');
        }
        _print(stringBufferStart.toString(),xtermRgb);
      } else {
        stringBufferStart.write('[');
        _print(stringBufferStart.toString(),xtermRgb);
        list.forEach((item) {
          index++;
          if (item is Map) {
            _resolveMap(space, item, index != list.length,xtermRgb);
          } else if (item is List) {
            _resolveList(space + 1, item, index != list.length,xtermRgb);
          } else {
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.write('|');
            for (int i = 0; i < space + 1; i++) {
              stringBuffer.write('\t');
            }
            if (item is String) {
              stringBuffer.write('\"' + item.toString() + '\"');
            } else {
              stringBuffer.write(item);
            }
            if (index != list.length) {
              stringBuffer.write(',');
            }
            _print(stringBuffer.toString(),xtermRgb);
          }
        });
        StringBuffer stringBufferEnd = new StringBuffer();
        stringBufferEnd.write('|');
        for (int i = 0; i < space; i++) {
          stringBufferEnd.write('\t');
        }
        stringBufferEnd.write(']');
        if (isLast) {
          stringBufferEnd.write(',');
        }
        _print(stringBufferEnd.toString(),xtermRgb);
      }
    }
  }

  static _print(Object? object,int? xtermRgb){
    print('\x1B[38;5;${xtermRgb}m$object\x1B[0m');
  }
}

/// xterm color 256
/// ColorConfig(infoRgb:xtermRgb(Colors.red.red,Colors.red.green,Colors.red.blue));
class ColorConfig{
  /// xterm color
  final int? infoRgb;
  /// xterm color
  final int? debugRgb;
  /// xterm color
  final int? warnRgb;
  /// xterm color
  final int? errorRgb;

  ColorConfig({this.infoRgb = 10, this.debugRgb = 14, this.warnRgb = 11, this.errorRgb = 9});
}

/// red 0-255
///
/// red green-255
///
/// red blue-255
///
/// return xterm color
int xtermRgb(int red, int green, int blue) {
  return ((red / 255).clamp(0.0, 1.0) * 5).toInt() * 36 +
      ((green / 255).clamp(0.0, 1.0) * 5).toInt() * 6 +
      ((blue / 255).clamp(0.0, 1.0) * 5).toInt() +
      16;
}
