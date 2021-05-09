import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phishing Tools'),
      ),
      body: Center(
        child: GetList(),
      ),
    );
  }

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
}

class GetList extends StatefulWidget {
  const GetList({Key key}) : super(key: key);

  @override
  _GetListState createState() => _GetListState();
}

class _GetListState extends State<GetList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              return ExpansionTile(
                title: Text(document['title']),
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: _util(document),
                  )
                ],
              );
            }).toList(),
          );

        });
  }
  _util(var document) {
    return Text(
      document['content'],
      style: new TextStyle(fontSize: 18.0),
    );
  }
}
