import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forehead_guess/ui/widgets/empty_placeholder.dart';
import 'package:forehead_guess/util/shared_prefs.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../design/fg_design.dart';
import '../../main.dart';
import '../../util/constants.dart';

class FGAccelerometerRecogniser extends ConsumerStatefulWidget {
  const FGAccelerometerRecogniser({
    Key? key,
    required this.onGuess,
  }) : super(key: key);

  final Function onGuess;

  @override
  ConsumerState<FGAccelerometerRecogniser> createState() =>
      _FGAccelerometerRecogniserState();
}

class _FGAccelerometerRecogniserState
    extends ConsumerState<FGAccelerometerRecogniser> {
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  double x = 0, y = 0, z = 0;
  String _direction = 'none';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
        if (!ref.read(decksService).gameEnded) {
          if (z > sharedPrefs.accelSensitivity - 1 && !_isLoading) {
            _isLoading = true;
            _direction = "up";
            ref.read(decksService).saveWordAndSetNewRandom(true);
            widget.onGuess(true);
            Timer(Duration(seconds: sharedPrefs.resultWaitSecondsRoll),
                () => {_isLoading = false});
          } else if (z < (sharedPrefs.accelSensitivity * (-1)) && !_isLoading) {
            _isLoading = true;
            _direction = "down";
            ref.read(decksService).saveWordAndSetNewRandom(false);
            widget.onGuess(false);
            Timer(Duration(seconds: sharedPrefs.resultWaitSecondsRoll),
                () => {_isLoading = false});
          } else {
            _direction = "to slow";
            y = 0;
          }
        }
      });
    }));
    Timer(Duration(seconds: sharedPrefs.resultWaitSecondsRoll),
        () => {_isLoading = false});
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return sharedPrefs.debug
        ? FGText.headingOne(
            '$_direction x:${x.toStringAsFixed(1)} y:${y.toStringAsFixed(1)} z:${z.toStringAsFixed(1)}')
        : const EmptyPlaceholder();
  }
}
