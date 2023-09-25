import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  final Color color;
  final bool selected;
  const ColorItem({
    super.key,
    required this.color,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: selected
            ? Border.all(
                color: Colors.white,
                strokeAlign: BorderSide.strokeAlignInside,
                width: 2,
              )
            : null,
      ),
    );
  }
}
