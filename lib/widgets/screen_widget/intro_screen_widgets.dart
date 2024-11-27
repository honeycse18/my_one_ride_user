import 'package:flutter/material.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

/// Per intro page content widget
class IntroContentWidget extends StatelessWidget {
  final Size screenSize;
  final String localImageLocation;
  final String slogan;
  final String subtitle;
  const IntroContentWidget({
    Key? key,
    required this.localImageLocation,
    required this.slogan,
    required this.subtitle,
    required this.screenSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(localImageLocation),
        ),
        Align(
          heightFactor: 100,
          alignment: Alignment.bottomCenter,
          child:
              HighlightAndDetailTextWidget(slogan: slogan, subtitle: subtitle),
        )
      ],
    );
  }
}
