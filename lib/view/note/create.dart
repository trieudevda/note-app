import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/view/widget/container.dart';
import '../../model/category.dart';
import '../../model/note.dart';

import '../widget/image/circle.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _categoryID = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  List<Categories> item=[];
  var dropdownValue;

  Future _getCategories()async{
    var data =await Categories.getAll();
    setState(() {
      item=data;
      dropdownValue=item.first;
      _categoryID.text=dropdownValue.id.toString();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _getCategories();
  }
  _create(BuildContext context)async{
    Note.create(context,Note(
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
              ImageCircleWidget(path: 'assets/images/logo.png',),
              sizedBox(height: 1),
              Container(
                height:50,
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<Categories>(
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
                            dropdownValue = value!;
                            _categoryID.text=(value.id).toString();
                          });
                        },
                        items: item.map<DropdownMenuItem<Categories>>((Categories value) {
                          return DropdownMenuItem<Categories>(
                            value: value,
                            child: Text(value.name.toString(),style: TextStyle(color: Colors.black),),
                          );
                        }).toList(),
                        value: dropdownValue,
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
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'description',
                ),
              ),
              sizedBox(height: 1),
              ElevatedButton(
                onPressed: () {
                  _create(context);
                },
                child: const Text("Gửi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
