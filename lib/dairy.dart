import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class DairyPage extends StatefulWidget {
  final Data data;
  final void Function(Data) onSaved;

  DairyPage({
    this.data,
    @required this.onSaved,
  });

  @override
  _DairyPageState createState() => _DairyPageState();
}

class _DairyPageState extends State<DairyPage> {
  TextEditingController textController;
  TextEditingController titleController;
  String editedText;
  String title;

  @override
  void initState() {
    super.initState();
    editedText = widget.data?.text ?? "";
    title = widget.data?.title ?? "";
    textController = TextEditingController(text: editedText);
    titleController = TextEditingController(text: title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              final newData = Data(
                title: title ?? "無題",
                text: editedText,
              );
              widget.onSaved(newData);
              Navigator.pop(context);
            },
          )),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: TextField(
                autofocus: true,
                controller: titleController,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: 'タイトル',
                ),
                onChanged: (String value) {
                  title = value;
                },
              )),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: TextField(

              autofocus: true,
              controller: textController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (String value) {
                editedText = value;
              },
            ),
          )
        ],
      ),
    );
  }
}
