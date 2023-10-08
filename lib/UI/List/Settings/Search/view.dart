import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/List/Settings/Search/view_controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';

class TodoListSearchView extends StatefulWidget {
  const TodoListSearchView({super.key});

  @override
  BaseState<TodoListSearchView> createState() => _TodoListSearchViewState();
}

class _TodoListSearchViewState extends BaseState<TodoListSearchView> {
  TodoListSearchViewController c = Get.put(TodoListSearchViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
          height: 40,
          width: dynamicWidth(1),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              filled: true,
              hintText: 'E-mail ara',
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
          dense: true,
          leading: CircleAvatar(
            child: Icon(Icons.person_outline),
          ),
          onTap: () {},
          title: Text('Akif Kadıoğlu'),
          subtitle: Text('akif.kadioglu.28@gmail.com'),
          isThreeLine: false,
          subtitleTextStyle: TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
