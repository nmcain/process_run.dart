library tekartik_cmdo.dartbin_utils;

import 'dart:io';
import 'package:path/path.dart';
import 'cmdo.dart';

String _dartVmBin;

bool _debug = false;

///
/// Get dart vm either from executable or using the which command
///
String get dartVmBin {
  if (_dartVmBin == null) {
    _dartVmBin = Platform.resolvedExecutable;

    /*
    if (_debug) {
      print('dartVmBin: ${_dartVmBin}');
    }
    if (FileSystemEntity.isLinkSync(_dartVmBin)) {
      String link = _dartVmBin;
      _dartVmBin = new Link(_dartVmBin).targetSync();

      // on mac, if installed with brew, we might get something like ../Cellar/dart/1.12.1/bin
      // so make sure to make it absolute
      if (!isAbsolute(_dartVmBin)) {
        _dartVmBin = absolute(normalize(join(dirname(link), _dartVmBin)));
      }
    }
    */
  }
  return _dartVmBin;
}

String get _dartBinDirPath => dirname(dartVmBin);

String get _dartVmBinExecutable => dartVmBin;

CommandInput _dartBinCmd(List<String> arguments) =>
    commandInput(_dartVmBinExecutable, arguments);

List<String> _dartCmdArguments(String cmd, List<String> args) {
  // clone it
  args = new List.from(args);
  args.insert(0, join(_dartBinDirPath, 'snapshots', '${cmd}.dart.snapshot'));
  return args;
}

List<String> dartFmtArguments(List<String> args) =>
    _dartCmdArguments('dartfmt', args);
CommandInput dartFmtCmd(List<String> args) =>
    _dartBinCmd(dartFmtArguments(args));
List<String> dartAnalyzerArguments(List<String> args) =>
    _dartCmdArguments('dartanalyzer', args);
CommandInput dartAnalyzerCmd(List<String> args) =>
    _dartBinCmd(dartAnalyzerArguments(args));
List<String> dart2JsArguments(List<String> args) =>
    _dartCmdArguments('dart2js', args);
CommandInput dart2JsCmd(List<String> args) =>
    _dartBinCmd(dart2JsArguments(args));
List<String> pubArguments(List<String> args) => _dartCmdArguments('pub', args);
CommandInput pubCmd(List<String> args) => _dartBinCmd(pubArguments(args));
