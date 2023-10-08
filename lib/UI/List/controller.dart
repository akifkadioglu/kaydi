import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> deleteTask(BuildContext context, double width) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Görev silinsin mi?'),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('İptal'),
                ),
              ),
              SizedBox(
                width: width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 23, 116, 153),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: Text('Sil'),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<dynamic> showTask(BuildContext context, double width, String task) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        alignment: Alignment.center,
        scrollable: true,
        elevation: 0,
        content: Text(task),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Kapat'),
                ),
              ),
              SizedBox(
                width: width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 23, 116, 153),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: Text('İşaretle'),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
