import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/view/widget/container.dart';
import '../../model/category.dart';
import '../../model/note.dart';
import '../widget/image/circle.dart';

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
  List<Categories> item=[];
  late Categories dropdownValue;

  Future<void> _get() async{
    List<Categories> data1 =await Categories.getAll();
    Note data2 =await Note.find(widget.note.id);
    setState(() {
      item=data1;
      _categoryID.text=data2.category_id.toString();
      _title.text=data2.title;
      _description.text=data2.description??'';
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue=widget.note.categories!;
    _get();
  }
  _update(BuildContext context)async{
    Note.update(context,Note(
        id: widget.note.id, title: _title.text, description: _description.text??'', category_id: int.parse(_categoryID.text)));
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
              ImageCircleWidget(path: 'assets/images/logo.png',),
              sizedBox(height: 1),
              SizedBox(
                height:50,
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
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
                            dropdownValue = item.firstWhere((dropdown) => dropdown.name == value);
                            _categoryID.text=dropdownValue.id.toString();
                          });
                        },
                        items: item.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name.toString(),style: const TextStyle(color: Colors.black),),
                          );
                        }).toList(),
                        value: dropdownValue.name,
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
