import 'package:app_lib/sqlapp.dart';
import 'package:app_lib/sqldb2d.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'moduols/componts.dart';

class Addnote extends StatefulWidget {
  const Addnote({Key? key}) : super(key: key);

  @override
  _AddnoteState createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  DateTime Timedate = DateTime.now();

  String formattedDate =
      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Form(
                key: formstate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    textformfildeditandadd(
                      controller: title,
                      textnotes: 'عنوان الملاحظة',
                      valida: (value) {
                        if (value!.isEmpty) {
                          return "لا يمكنك ترك العنوان فارغ !";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textformfildeditandadd(
                      controller: note,
                      textnotes: 'ملاحظاتك',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formstate.currentState!.validate()) {
                            int responses = await sqlDb.insertData(
                                'INSERT INTO noote(title,mems,datetime) VALUES("${title.text}","${note.text}","${formattedDate}")');
                            setState(() {});
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => Sqlapp(),
                                ),
                                (route) => false);

                            print("data add done");
                            print(responses);
                          }
                        },
                        child: Text("إضافة الملاحظة",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      child: Text("BY: Emad Younis"),
                    ),
                  ],
                ),
              )
            ],
          )),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 37, 109, 133),
        title: Text(
          "إضافة ملاحظة",
        ),
      ),
    );
  }
}
