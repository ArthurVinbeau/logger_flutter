part of logger_flutter;

class LogConsoleOnShake extends StatefulWidget {
  final Widget child;
  final bool debugOnly;
  final double shakeThresholdGravity;
  final int minTimeBetweenShakes;
  final int shakeCountResetTime;
  final int minShakeCount;
  final bool fitWidth;

  LogConsoleOnShake({
    required this.child,
    this.debugOnly = true,
    this.shakeThresholdGravity = 1.25,
    this.minTimeBetweenShakes = 160,
    this.shakeCountResetTime = 1500,
    this.minShakeCount = 2,
    this.fitWidth = true,
  });

  @override
  _LogConsoleOnShakeState createState() => _LogConsoleOnShakeState();
}

class _LogConsoleOnShakeState extends State<LogConsoleOnShake> {
  late ShakeDetector _detector;
  bool _open = false;

  @override
  void initState() {
    super.initState();

    if (widget.debugOnly) {
      assert(() {
        _init();
        return true;
      }());
    } else {
      _init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  _init() {
    _detector = ShakeDetector(
      onPhoneShake: _openLogConsole,
      shakeThresholdGravity: widget.shakeThresholdGravity,
      minTimeBetweenShakes: widget.minTimeBetweenShakes,
      shakeCountResetTime: widget.shakeCountResetTime,
      minShakeCount: widget.minShakeCount,
    );
    _detector.startListening();
  }

  _openLogConsole() async {
    if (_open) return;

    _open = true;

    var logConsole = LogConsole(
      showCloseButton: true,
      dark: false,
      fitWidth: widget.fitWidth,
    );
    PageRoute route;
    if (Platform.isIOS) {
      route = CupertinoPageRoute(builder: (_) => logConsole);
    } else {
      route = MaterialPageRoute(builder: (_) => logConsole);
    }

    await Navigator.push(context, route);
    _open = false;
  }

  @override
  void dispose() {
    _detector.stopListening();
    super.dispose();
  }
}
