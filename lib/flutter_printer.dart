import 'package:flutter/material.dart';

class Printer {
  static bool enable = true;

  ///Print String
  static void printLog(dynamic content) {
    if (enable) {
      _warp(content.toString());
    }
  }
  ///Print map or list, etc.
  ///state Current state
  ///lineNum Printed location
  static void printMapJsonLog(dynamic content, {State state, int lineNum}) {
    if (enable) {
      _warpMapJson(content, state: state, lineNum: lineNum);
    }
  }

  ///Format json data
  static void _warpJson(String msg) {
    if (!msg.contains("{") && !msg.contains("}")) {
      print("   "+msg);
    } else {
      RegExp regExp = RegExp(r"{|}|\[|,");
      String rs = msg.replaceAllMapped(regExp, (Match m) => "${m[0]}\n");
      //    print(rs);
      String rs1 = rs.substring(0, rs.length - 2) + "\n}";
      //    print(rs1);
      String rsResult = rs1.replaceAllMapped(RegExp("\n"), (Match m) {
        return "${m[0]}\t\t";
      });
      print("\t\t" + rsResult.substring(0, rsResult.length - 1) + "}");
    }
  }

  ///With indentation
  static void _warpMapJson(dynamic msg, {State state, int lineNum: 0}) {
    String top =
        "┌------------------------------------------------------------------------------------------------------------------------------------------┐";
    String bottom =
        "└------------------------------------------------------------------------------------------------------------------------------------------┘";
    ///current State ---->
    String stateName = "StateName ----> " +
        state.toString().split("#")[0].toString() +
        ", lineNum ----> " +
        lineNum.toString();
    top = top.replaceRange(10, stateName.length, stateName);
    bottom = bottom.replaceRange(10, stateName.length, stateName);
    print(top);
    _genReadableJson(msg);

    print(bottom);
  }

  ///Format json data by type
  static void _genReadableJson(dynamic data) {
    if (data is List) {
      _resolveList(1, data, false);
    } else if (data is Map) {
      _resolveMap(1, data);
    } else {
      if (data == null) {
        print("   null");
      } else {
        _warpJson(data.toString());
      }
    }
  }

  ///Format json
  static void _resolveMap(int space, Map<dynamic, dynamic> data) {
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
      stringBuffer.write(":");
      if (value is Map) {
        print(stringBuffer.toString());
        _resolveMap(space, value);
        if (index == data.length - 1) {
          StringBuffer stringBuffer = new StringBuffer();
          stringBuffer.write("|");
          for (int i = 0; i < space + 1; i++) {
            stringBuffer.write("\t");
          }
          stringBuffer.write(",");
          print(stringBuffer.toString());
        }
      } else if (value is List) {
        print(stringBuffer.toString());
        space++;
        _resolveList(space, value, index != data.length);
      } else {
        var v = value;
        if (v == null) {
          stringBuffer.write("null");
        } else {
          stringBuffer.write("\"" + value.toString() + "\"");
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
    if (index == data.length) {
    }

    print(stringBufferEnd.toString());
  }

  ///Format list json
  static void _resolveList(int space, List list, bool isLast) {
    int index = 0;
    space++;
    StringBuffer stringBufferStart = new StringBuffer();
    stringBufferStart.write("|");
    for (int i = 0; i < space; i++) {
      stringBufferStart.write("\t");
    }
    stringBufferStart.write("[\n");
    print(stringBufferStart.toString());
    list.forEach((item) {
      index++;
      if (item is Map) {
        _resolveMap(space, item);
        if (index != list.length) {
          StringBuffer stringBufferMapEnd = new StringBuffer();
          stringBufferMapEnd.write("|");
          for (int i = 0; i < space + 1; i++) {
            stringBufferMapEnd.write("\t");
          }
          stringBufferMapEnd.write(",");
          print(stringBufferMapEnd.toString());
        }
      } else if (item is List) {
        space++;
        _resolveList(space, item, isLast);
      } else {
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.write("|");
        for (int i = 0; i < space; i++) {
          stringBuffer.write("\t");
        }
        stringBuffer.write("\"" + item.toString() + "\"");
        stringBuffer.write(",");
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

  ///Wrapped String
  static void _warp(String msg) {
    print(
        "┌------------------------------------------------------------------------------------------------------------------------------------------┐");
    RegExp regExp = RegExp(r"{|}|\[");
    String rs = msg.replaceAllMapped(regExp, (Match m) => "${m[0]}\n");
    print("│\t" + rs);
    print(
        "└------------------------------------------------------------------------------------------------------------------------------------------┘");
  }
}
