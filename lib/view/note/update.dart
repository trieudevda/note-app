import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/view/widget/container.dart';
import '../../model/category.dart';
import '../../model/note.dart';
import 'dart:math' as math;

class UpdateNotePage extends StatefulWidget {
  UpdateNotePage({super.key,required this.note});
  Note note;
  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  final TextEditingController _categoryID = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  List<Map<String, dynamic>> item=[];
  var dropdownValue;

  Future _get()async{
    var data1 =await Categories.getAll();
    Map<String, dynamic> data2 =await Categories.find(widget.note.category_id);
    data2=data2['category'];
    setState(() {
      item=data1;
      dropdownValue=data2;
      print('data 1'+ dropdownValue.toString());
      print(dropdownValue.runtimeType);

      print(dropdownValue==item.first);
      // dropdownValue=data2['note']['category']['name'];
      _categoryID.text=dropdownValue['id'].toString();
      _title.text=dropdownValue['title']??'';
      _description.text=dropdownValue['description']??'';
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _get();
  }
  _update(BuildContext context)async{
    Note.update(context,Note(
        id: 0, title: _title.text, description: _description.text??'', category_id: int.parse(_categoryID.text)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo ghi chú mới'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              sizedBox(height: 1),
              SizedBox(
                height:50,
                child: Row(
                  children: [
                    Expanded(
                      child: FutureBuilder(
                        future: Categories.getAll(),
                        builder: (context,snapshot) {
                          return DropdownButton<Map<String,dynamic>>(
                            hint: const Text('chưa có dữ liệu'),
                            isExpanded: true,
                            icon: const FaIcon(FontAwesomeIcons.chevronDown),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            onChanged: (value) {
                              setState(() {
                                dropdownValue = value;
                                _categoryID.text=value.toString();
                                print(dropdownValue);
                                print(_categoryID.text);
                              });
                            },
                            items: item.map<DropdownMenuItem<Map<String,dynamic>>>((value) {
                              print(value);
                              print(value.runtimeType);
                              return DropdownMenuItem<Map<String,dynamic>>(
                                value: value,
                                child: Text(value['name'].toString(),style: const TextStyle(color: Colors.black),),
                              );
                            }).toList(),
                            value: dropdownValue,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: 'title',
                ),
              ),
              sizedBox(height: 1),
              TextField(
                controller: _description,
                decoration: const InputDecoration(
                  labelText: 'description',
                ),
              ),
              sizedBox(height: 1),
              ElevatedButton(
                onPressed: () {
                  _update(context);
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
