import 'package:flutter/material.dart';
import 'package:herewego/modal/post_modal.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/service/auth_service.dart';
import 'package:herewego/service/prefs_sevice.dart';
import 'package:herewego/service/rtdb_service.dart';

class HomePage extends StatefulWidget {

  static final String id = "home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post> items = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add(new Post("123","Title","Content","Pdp","123"));
    items.add(new Post("123","Title","Content","Pdp","123"));
    items.add(new Post("123","Title","Content","Pdp","123"));
    _apiGetPosts();
  }



  Future _openDetail() async{
    Map results = await Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context){
          return new DetailPage();
        }
    ));
    if(results != null && results.containsKey("data")){
      print(results['data']);
      _apiGetPosts();
    }
  }

  _apiGetPosts() async{
    var id = await Prefs.loadUserId();
    RTDBService.getPosts(id).then((posts) => {
      _resPosts(posts),
    });
  }

  _resPosts(List<Post> posts){
    setState(() {
      items = posts;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app,color: Colors.white,),
              onPressed:(){
                AuthService.signOutUser(context);
              }
          )
        ],
        title: Center(
          child: Text("All Posts"),
        ),
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx,i){
            return itemOfList(items[i]);
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDetail,
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

  Widget itemOfList(Post post){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
           children: [
             Text(post.firstname,style: TextStyle(color: Colors.black,fontSize: 20),),
             SizedBox(width: 10,),
             Text(post.lastname,style: TextStyle(color: Colors.black,fontSize: 20),),
             SizedBox(height: 7,),
           ],
         ),
          SizedBox(height: 5,),
          Text(post.data,style: TextStyle(color: Colors.black,fontSize: 17),),
          SizedBox(height: 5,),
          Text(post.content,style: TextStyle(color: Colors.black,fontSize: 17),),
        ],
      ),
    );
  }
}

