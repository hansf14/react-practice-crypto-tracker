import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart'; // HapticFeedback
// import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum PomodoroType {
  work,
  rest,
}

class _HomeScreenState extends State<HomeScreen> {
  static const initialWorkTotalSeconds = 10;
  static const initialRestTotalSeconds = 5;

  int workTotalSeconds = initialWorkTotalSeconds;
  int restTotalSeconds = initialRestTotalSeconds;
  int initialTotalSeconds = initialWorkTotalSeconds;
  int totalSeconds = initialWorkTotalSeconds;
  bool isRunning = false;
  PomodoroType currentPomodoroType = PomodoroType.work;
  int workPomodoros = 0;
  int restPomodoros = 0;
  late Timer timer;

  bool canVibrate = false;

  void _checkCanVibrate() async {
    // check if device can vibrate
    try {
      // Check vibration physical capability`
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        print(
            "Platform.operatingSystemVersion: ${Platform.operatingSystemVersion}"); // QP1A.190711.020.A600NKSS8CWA1
        if (Platform.isAndroid) {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
          print(
              "androidDeviceInfo.version.sdkInt: ${androidDeviceInfo.version.sdkInt}"); // 29
        }

        canVibrate = await Vibration.hasVibrator() ?? false;
      }
    } catch (e) {
      print(e);
    }
    print("canVibrate: $canVibrate");
  }

  void _vibrate() {
    if (canVibrate) {
      print("Vibration starts!");

      // HapticFeedback.mediumImpact();

      // Use `Vibration.vibrate` over `HapticFeedback`.
      // Some devices not support `HapticFeedback`.
      Vibration.vibrate(duration: 1000);
    }
  }

  void _increaseCurrentPomodoro() {
    switch (currentPomodoroType) {
      case PomodoroType.work:
        workPomodoros++;
        break;
      case PomodoroType.rest:
        restPomodoros++;
        break;
      default:
        print(
            "Warn: _increaseCurrentPomodoro - No such type for the PomodoroType: ${currentPomodoroType.name}");
        break;
    }
  }

  String _getCurrentPomodoroString() {
    switch (currentPomodoroType) {
      case PomodoroType.work:
        return "Work";
      case PomodoroType.rest:
        return "Rest";
      default:
        print(
            "Warn: _increaseCurrentPomodoro - No such type for the PomodoroType: ${currentPomodoroType.name}");
        return "";
    }
  }

  void _switchCurrentPomodoroType() {
    switch (currentPomodoroType) {
      case PomodoroType.work:
        currentPomodoroType = PomodoroType.rest;
        initialTotalSeconds = initialRestTotalSeconds;
        totalSeconds = initialTotalSeconds;
        break;
      case PomodoroType.rest:
        currentPomodoroType = PomodoroType.work;
        initialTotalSeconds = initialWorkTotalSeconds;
        totalSeconds = initialTotalSeconds;
        break;
      default:
        print(
            "Warn: _switchCurrentPomodoroType - No such type for the PomodoroType: ${currentPomodoroType.name}");
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _checkCanVibrate();
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      // 카운트 다운 끝남
      setState(() {
        _increaseCurrentPomodoro();
        isRunning = false;
        totalSeconds = initialTotalSeconds;
      });
      timer.cancel();

      //타이머가 끝나면 진동
      _vibrate();

      // 일 <-> 휴식 스위치
      _switchCurrentPomodoroType();
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = initialTotalSeconds;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    // return duration.toString().split(".").first.substring(2, 7);

    var hmsList = duration.toString().split(".").first.split(":");
    var minuteStr = hmsList[1].padLeft(2, "0");
    var secondStr = hmsList.last.padLeft(2, "0");
    return "$minuteStr:$secondStr";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Center(
          child: Text("Pomodoro"),
        ),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Flexible(
              flex: 2, // Default value
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "Current Pomodoro",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1?.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "\" ${_getCurrentPomodoroString()} \"",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline2?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 9,
                      fit: FlexFit.tight,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          format(totalSeconds),
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Center(
                      child: SizedBox.expand(
                        child: IconButton(
                          onPressed:
                              isRunning ? onPausePressed : onStartPressed,
                          icon: SizedBox.expand(
                            child: FittedBox(
                              child: Icon(
                                isRunning
                                    ? Icons.pause_circle_outline
                                    : Icons.play_circle_outline,
                              ),
                            ),
                          ),
                          color: Theme.of(context).textTheme.button?.color,
                          // padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Center(
                      child: SizedBox.expand(
                        child: IconButton(
                          onPressed: onResetPressed,
                          icon: const SizedBox.expand(
                            child: FittedBox(
                              child: Icon(
                                Icons.stop_circle_outlined,
                              ),
                            ),
                          ),
                          color: Theme.of(context).textTheme.button?.color,
                          // padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        // BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    "Pomodoros",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.color,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    "Work: $workPomodoros",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.color,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    "Rest: $restPomodoros",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.color,
                                    ),
                                  ),
                                ),
                              ),
                            ].fold(
                                [],
                                (a, b) => [
                                      ...a,
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      b
                                    ]), // intersperse
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
