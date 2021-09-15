class Printer {
  ///是否开启打印 Whether to turn on printing

  static bool enable = true;

  ///Print map or list, etc.
  ///stackTrace stackTrace
  ///prefix prefix
  ///可已打印任意数据，stackTrace不为null时可显示出使用Printer的位置，prefix 打印数据前缀
  ///Any data can be printed. When the stackTrace is not null, the location where the printer is used can be displayed. The prefix prints the data prefix.

  static void printMapJsonLog(dynamic content,
      {StackTrace? stackTrace, String? prefix}) {
    if (enable) {
      _warpMapJson(content, stackTrace: stackTrace, prefix: prefix);
    }
  }


  ///With indentation
  static void _warpMapJson(dynamic msg,
      {StackTrace? stackTrace, String? prefix}) {
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
    print(top);
    if (prefix != null && prefix.trim().length != 0) {
      print("|\t" + prefix);
    }
    _genReadableJson(msg);

    print(bottom);
  }

  ///Format json data by type
  static void _genReadableJson(dynamic data) {
    if (data is List) {
      _resolveList(1, data, false);
    } else if (data is Map) {
      _resolveMap(1, data, false);
    } else {
      if(data is String){
        _splitStr(1,data);
      }else{
        print("|\t"+ data.toString());
      }
    }
  }

  static _splitStr(int space ,String? data){
    if(data != null && data.contains("\n")){
      StringBuffer stringBuffer = StringBuffer();
      List<String> list = data.split(RegExp(r"\n"));
      stringBuffer.write("|");
      for (int i = 0; i < space ; i++) {
        stringBuffer.write("\t");
      }
      list.forEach((str){
        _splitLineStr(space,str);
      });
    }else{
      _splitLineStr(space,data);
    }
  }

  static _splitLineStr(int space ,String? data) {
    StringBuffer stringBuffer = StringBuffer();
    int limit = 150;
    if (data != null && data.length > limit) {
      int count = data.length ~/ limit;
      stringBuffer.write("|");
      for (int i = 0; i < space; i++) {
        stringBuffer.write("\t");
      }
      for (int i = 0; i < count; i++) {
        if (i == count - 1) {
          print(
              stringBuffer.toString() + data.substring(i * limit, data.length));
        } else {
          print(stringBuffer.toString() +
              data.substring(i * limit, i * limit + limit));
        }
      }
    }else{
      print("|\t"+ data!);
    }
  }

  ///Format json
  static void _resolveMap(int space, Map<dynamic, dynamic> data, bool isLast) {
    int index = 0;
    space++;
    StringBuffer stringBufferStart = new StringBuffer();
    stringBufferStart.write("|");
    for (int i = 0; i < space; i++) {
      stringBufferStart.write("\t");
    }
    stringBufferStart.write("{\n");
    print(stringBufferStart.toString());
    data.forEach((key, value) {
      index++;
      StringBuffer stringBuffer = new StringBuffer();
      stringBuffer.write("|");
      for (int i = 0; i < space + 1; i++) {
        stringBuffer.write("\t");
      }
      stringBuffer.write("\"" + key + "\"");
      stringBuffer.write(" : ");
      if (value is Map) {
        print(stringBuffer.toString());
        _resolveMap(space + 1, value, index != data.length);
      } else if (value is List) {
        if (value.length == 0) {
          stringBuffer.write("[]");
          if(index != data.length){
            stringBuffer.write(",");
          }
          print(stringBuffer.toString());
        } else {
          print(stringBuffer.toString());
          _resolveList(space + 1, value, index != data.length);
        }
      } else {
        if (value == null) {
          stringBuffer.write(null);
        } else {
          if (value is String) {
            stringBuffer.write("\"" + value.toString() + "\"");
          } else {
            stringBuffer.write(value);
          }
        }
        if (index != data.length) {
          stringBuffer.write(",");
        }
        stringBuffer.write("\n");
        print(stringBuffer.toString());
      }
    });

    StringBuffer stringBufferEnd = new StringBuffer();
    stringBufferEnd.write("|");
    for (int i = 0; i < space; i++) {
      stringBufferEnd.write("\t");
    }
    stringBufferEnd.write("}");
    if (isLast) {
      stringBufferEnd.write(",");
    }

    print(stringBufferEnd.toString());
  }

  ///Format list json
  static void _resolveList(int space, List? list, bool isLast) {
    int index = 0;
    space++;
    StringBuffer stringBufferStart = new StringBuffer();
    stringBufferStart.write("|");
    for (int i = 0; i < space; i++) {
      stringBufferStart.write("\t");
    }

    if (list == null) {
      stringBufferStart.write(null);
      print(stringBufferStart.toString());
    } else {
      if (list.length == 0) {
        stringBufferStart.write("[]");
        if (isLast) {
          stringBufferStart.write(",");
        }
        print(stringBufferStart.toString());
      } else {
        stringBufferStart.write("[");
        print(stringBufferStart.toString());
        list.forEach((item) {
          index++;
          if (item is Map) {
            _resolveMap(space, item, index != list.length);
          } else if (item is List) {
            _resolveList(space + 1, item, index != list.length);
          } else {
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.write("|");
            for (int i = 0; i < space + 1; i++) {
              stringBuffer.write("\t");
            }
            if (item is String) {
              stringBuffer.write("\"" + item.toString() + "\"");
            } else {
              stringBuffer.write(item);
            }
            if (index != list.length) {
              stringBuffer.write(",");
            }
            print(stringBuffer.toString());
          }
        });
        StringBuffer stringBufferEnd = new StringBuffer();
        stringBufferEnd.write("|");
        for (int i = 0; i < space; i++) {
          stringBufferEnd.write("\t");
        }
        stringBufferEnd.write("]");
        if (isLast) {
          stringBufferEnd.write(",");
        }
        print(stringBufferEnd.toString());
      }
    }
  }

}
