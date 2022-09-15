import 'package:firebase_database/firebase_database.dart';
import 'package:firebasedemo/insertpage.dart';
import 'package:flutter/material.dart';

class dataview extends StatefulWidget {
  const dataview({Key? key}) : super(key: key);

  @override
  State<dataview> createState() => _dataviewState();
}

class _dataviewState extends State<dataview> {
  List l = [];

  @override
  void initState() {
    super.initState();

  }
  loaddata()
  async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook");

    DatabaseEvent de = await ref.once();

    DataSnapshot ds = de.snapshot;

    print(ds.value);

    Map map = ds.value as Map;

    map.forEach((key, value) {
      l.add(value);
    });

    setState(() {
      print(l);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appbar"),),
      body:l.length > 0 ?
      ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          Map m= l[index];
        return ListTile(
          onTap: () {
            showDialog(builder:(context) {
              return SimpleDialog(
                title: Text("Select choice"),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
                        return insertpage(m:m);
                      },));

                    },
                    title: Text("update"),
                  ),
                  ListTile(
                    onTap: () async {
                      Navigator.pop(context);
                      String userid = m['userid'];
                      DatabaseReference ref = FirebaseDatabase
                          .instance
                          .ref("contactbook")
                          .child(userid);

                      await ref.remove();

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(
                            builder: (context) {
                              return dataview();
                            },
                          ));
                    },
                    title: Text("Delete"),
                  ),
                ],
              );

            },context: context );

          },
          title: Text("${m['name']}"),
          subtitle: Text("${m['contact']}"),
        );

      },)
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return insertpage();
            },
          ));
        },
      ),
    );
  }
}
