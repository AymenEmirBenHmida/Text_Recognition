/// Flutter code sample for Flow

// This example uses the [Flow] widget to create a menu that opens and closes
// as it is interacted with, shown above. The color of the button in the menu
// changes to indicate which one has been selected.
//@dart=2.9
import 'package:face_recognition/UI/second_page.dart';
import 'package:flutter/material.dart';

class FlowMenu extends StatefulWidget {
  final Function(IconData) onCountSelected;
  final Function(int) onCountChanged;
  FlowMenu({this.onCountSelected, @required this.onCountChanged, Key key})
      : super(key: key);

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu>
    with SingleTickerProviderStateMixin {
  AnimationController menuAnimation;
  IconData lastTapped = Icons.notifications;
  final List<IconData> menuItems = <IconData>[
    Icons.menu,
    Icons.camera_alt_outlined,
    Icons.drive_file_move_outlined,
  ];

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() => lastTapped = icon);
    }
  }

  getIcon() {
    return lastTapped;
  }

  @override
  void initState() {
    super.initState();
    menuAnimation = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  Widget flowMenuItem(IconData icon) {
    final double buttonDiameter = 50.0;
    return RawMaterialButton(
      fillColor: lastTapped == icon ? Colors.amber[700] : Colors.red,
      splashColor: Colors.amber[100],
      shape: const CircleBorder(),
      constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
      onPressed: () {
        _updateMenu(icon);
        menuAnimation.status == AnimationStatus.completed
            ? menuAnimation.reverse()
            : menuAnimation.forward();
        print("inside the method where callback function is being called");
        widget.onCountSelected(icon);
        widget.onCountChanged(1);
      },
      child: Icon(
        icon,
        color: Colors.white,
        size: 30.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(menuAnimation: menuAnimation),
      children:
          menuItems.map<Widget>((IconData icon) => flowMenuItem(icon)).toList(),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({this.menuAnimation}) : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;

    final xStart = size.width - 55;

    final yStart = size.height - 55;
    final margin = 8;

    for (int i = context.childCount - 1; i >= 0; i--) {
      final childSize = context.getChildSize(i).width;
      final dx = (childSize + margin) * i;
      final x = xStart - dx * menuAnimation.value;
      final y = yStart;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          x,
          y,
          0,
        ),
      );
    }
  }
}
