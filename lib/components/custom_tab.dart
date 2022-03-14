import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTab extends StatelessWidget {
  const CustomTab(
      {Key? key,
      this.width = 80,
      this.height = 70,
      this.isActive = false,
      this.assetName,
      this.text})
      : super(key: key);

  final double width;
  final double height;
  final bool isActive;
  final String? assetName;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Tab(
        child: text != null
            ? Text(
                text!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isActive
                      ? Colors.white
                      : Theme.of(context).colorScheme.onTertiary,
                ),
              )
            : null,
        icon: assetName != null
            ? SvgPicture.asset(
                assetName!,
                color: isActive
                    ? Colors.white
                    : Theme.of(context).colorScheme.onTertiary,
              )
            : null,
      ),
    );
  }
}
