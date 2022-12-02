import 'package:flutter/material.dart';
import 'package:frontend/data/bottom_bar.data.dart';

class BottomBarPage extends StatefulWidget {
  final List<BottomBarData> items;
  final int checkedItem;
  final Color selectedColor;
  final Color backgroundColor;

  BottomBarData getCurrentItem(int index) {
    return items.elementAt(index);
  }

  const BottomBarPage({
    super.key,
    this.items = const [],
    this.checkedItem = 0,
    this.selectedColor = Colors.blue,
    this.backgroundColor = Colors.black87
  });

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int _currentIndex = 0;

  BottomBarData _getCurrentItem(int index) {
    return widget.items.elementAt(index);
  }

  void _onTap(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    BottomBarData selectedItem = _getCurrentItem(_currentIndex);
    Color barBackgroundColor = Color.alphaBlend(widget.backgroundColor, selectedItem.color);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem.label)
      ),
      body: Center(
        child: selectedItem.content,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widget.items.map((BottomBarData item) {
          return BottomNavigationBarItem(
            icon: item.icon,
            label: item.label,
            backgroundColor: item.color,
          );
        }).toList(),
        currentIndex: _currentIndex,
        selectedItemColor: widget.selectedColor,
        onTap: _onTap,
        backgroundColor: barBackgroundColor,
      ),
    );
  }
}