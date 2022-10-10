import 'package:app_lib/editenote.dart';
import 'package:app_lib/sqldb2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'moduols/componts.dart';

class Sqlapp extends StatefulWidget {
  const Sqlapp({Key? key}) : super(key: key);

  @override
  _SqlappState createState() => _SqlappState();
}

class _SqlappState extends State<Sqlapp> {
  Color Colorback = Color.fromARGB(255, 36, 106, 129);
  Color Colorfonttitle = Colors.white;
  Color Colorsubfonttitle = Color.fromARGB(255, 216, 213, 213);
  SqlDb sqlDb = SqlDb();
  bool isloading = true;
  Future readData() async {
    notes = [];
    List<Map> response = await sqlDb.readData("SELECT * FROM noote");
    notes.addAll(response);
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 37, 109, 133),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 10),
            child: Icon(Icons.note),
          )
        ],
        title: Text(
          "ملاحظاتي",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 37, 109, 133),
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        color: Color.fromARGB(255, 37, 109, 133),
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 35,
            )
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            ListView.builder(
              itemCount: notes.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: ((context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      trailing: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          iconsbuttondefult(
                            iconsbtn: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onpressed: () async {
                              int response = await sqlDb.deleteData(
                                  'DELETE FROM noote WHERE id = ${notes[i]['id']}');
                              notes.removeWhere(
                                  (element) => element['id'] == notes[i]['id']);
                              setState(() {});
                            },
                          ),
                          iconsbuttondefult(
                            iconsbtn: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onpressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Editnote(
                                    title: notes[i]['title'],
                                    mems: notes[i]['mems'],
                                    id: notes[i]['id'],
                                  ),
                                ),
                              );
                            },
                          ),
                          Column(
                            children: [],
                          )
                        ],
                      ),
                      contentPadding: EdgeInsets.all(10),
                      tileColor: Colorback,
                      isThreeLine: true,
                      title: textdefult(
                          colorfont: Colorfonttitle,
                          textfildtitle: '${notes[i]["title"]}'),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textdefult(
                              colorfont: Colorsubfonttitle,
                              textfildtitle: '${notes[i]["mems"]}'),
                          textdefult(
                              colorfont: Colorsubfonttitle,
                              textfildtitle: '${notes[i]["datetime"]}'),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
