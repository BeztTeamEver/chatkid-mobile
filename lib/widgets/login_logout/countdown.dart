import 'package:flutter/material.dart';

class CountdownWidget extends StatelessWidget {
  const CountdownWidget({
    super.key,
    required int remainingTime,
  }) : _remainingTime = remainingTime;

  final int _remainingTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          // timout the code text
          style: Theme.of(context).textTheme.bodySmall!.copyWith(),
          TextSpan(
            children: <TextSpan>[
              const TextSpan(text: 'Mã xác nhận sẽ hết hạn sau '),
              TextSpan(
                text: "${_remainingTime}s",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        Text.rich(
          style: Theme.of(context).textTheme.bodySmall!.copyWith(),
          TextSpan(
            children: <TextSpan>[
              const TextSpan(text: 'Không nhận được mã? '),
              TextSpan(
                text: 'Gửi lại',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
