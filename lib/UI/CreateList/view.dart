import 'package:flutter/material.dart';

class CreateListView extends StatefulWidget {
  const CreateListView({super.key});

  @override
  State<CreateListView> createState() => _CreateListViewState();
}

class _CreateListViewState extends State<CreateListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Create List'),
      ),
    );
  }
}
