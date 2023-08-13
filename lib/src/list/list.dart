import 'package:flutter/material.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'List View Page',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}