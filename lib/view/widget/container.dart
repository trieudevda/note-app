import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/view/note/update.dart';

Widget sizedBox({double height = 1}) {
  return SizedBox(height: 16 * height);
}

Widget itemList(BuildContext context,Note note) {
  return Container(
    padding: const EdgeInsets.only(left: 10,right:10),
    margin: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black12),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(note.title),
            IconButton(
                onPressed: (){
                  Note.delete(context,note.id);
                  Navigator.pushNamed(context, '/home');
                },
                icon: const FaIcon(FontAwesomeIcons.trash,size: 16,),
            ),
          ],
        ),
        const Divider(),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Nội dung: ${note.description ?? 'chờ cập nhật'}",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(note.updated_at??note.created_at??'chờ cập nhật'),
            TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateNotePage(note: note)),
                );
              },
              child: Text('Xem thêm >'),
            ),
          ],
        ),
      ],
    ),
  );
}
