import 'package:flutter/material.dart';

class CountDownWidget extends AnimatedWidget {
  Animation<int> animation;
  final VoidCallback onResendTap;
  CountDownWidget(
      {super.key, required this.animation, required this.onResendTap})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return GestureDetector(
      onTap: () {
        if (timerText == '0:00') {
          onResendTap();
        }
      },
      child: Text(
        timerText == '0:00' ? 'Resend OTP' : timerText,
        style: const TextStyle(color: Colors.green, fontSize: 14),
      ),
    );
  }
}
