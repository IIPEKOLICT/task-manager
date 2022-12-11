import 'package:flutter/material.dart';

class ListComponent extends StatelessWidget {
  final bool isLoading;
  final List<Widget> items;
  final String? placeholder;
  final VoidCallback? onAdd;

  const ListComponent({
    super.key,
    required this.isLoading,
    required this.items,
    this.placeholder,
    this.onAdd,
  });

  List<Widget> _renderItems(BuildContext context) {
    if (placeholder == null) return items;

    return items.isEmpty
        ? [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  placeholder!,
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ]
        : items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: isLoading ? const [LinearProgressIndicator()] : _renderItems(context),
      ),
      floatingActionButton: onAdd != null
          ? FloatingActionButton(
              onPressed: onAdd,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
