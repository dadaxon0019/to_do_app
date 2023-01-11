import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final mainTitle;
  final descriptionTitle;
  final taskNumb;

  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {Key? key,
      required this.onSave,
      required this.onCancel,
      required this.mainTitle,
      required this.taskNumb,
      required this.descriptionTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      content: Container(
        width: 300,
        constraints: BoxConstraints(
          maxHeight: 250,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1, //Normal textInputField will be displayed
              maxLines: 3,
              controller: mainTitle,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: 'Add Title Tasks',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1, //Normal textInputField will be displayed
              maxLines: 3,
              controller: descriptionTitle,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: 'Add Description Tasks',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                TextButton(
                  onPressed: onCancel,
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (mainTitle.text.isNotEmpty &&
                        descriptionTitle.text.isNotEmpty) {
                      return onSave();
                    } else {}
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
