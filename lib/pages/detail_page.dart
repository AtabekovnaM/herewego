import 'package:flutter/material.dart';
import 'package:herewego/modal/post_modal.dart';
import 'package:herewego/service/prefs_sevice.dart';
import 'package:herewego/service/rtdb_service.dart';

class DetailPage extends StatefulWidget {
  static final String id = "detail_page";
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var isLoading = false;
  var lastnameController = TextEditingController();
  var contentController = TextEditingController();
  var firstnameController = TextEditingController();
  var dataController = TextEditingController();

  _addPost() async {
    String firsname = firstnameController.text.toString();
    String content = contentController.text.toString();
    String lastname = lastnameController.text.toString();
    String data = dataController.text.toString();
    if (firsname.isEmpty || lastname.isEmpty || content.isEmpty || data.isEmpty) return;

    _apiAddPost(firsname,lastname,content,data);
  }

  _apiAddPost(String firstname, String lastname, String content, String data) async {
    var id = await Prefs.loadUserId();
    RTDBService.addPost(new Post(id, firstname, lastname,content,data)).then((response) => {
      _respAddPost(),
    });
  }

  _respAddPost(){
    Navigator.of(context).pop({'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Container(
          margin: EdgeInsets.only(left: 90),
          child: Text("Add Post"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(height: 15,),
              TextField(
                controller: firstnameController,
                decoration: InputDecoration(
                    hintText: "Firstname"
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: lastnameController,
                decoration: InputDecoration(
                    hintText: "Lastname"
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                    hintText: "Content"
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: dataController,
                decoration: InputDecoration(
                    hintText: "Date"
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: double.infinity,
                height: 45,
                child: FlatButton(
                  onPressed: _addPost,
                  color: Colors.deepOrange,
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}