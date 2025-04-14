import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppbar extends StatelessWidget {
  final String displayName;

  const HomeAppbar({super.key, required this.displayName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/images/DRIVESAFE.svg',
                  width: 150,
                ),
                Image.asset('assets/images/logo_DS.png', height: 30),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  displayName,
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

