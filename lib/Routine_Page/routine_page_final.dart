import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onwords_home/Routine_Page/task_data.dart';
import 'package:provider/provider.dart';

class RoutinePageFinal extends StatefulWidget {
  @override
  _RoutinePageFinalState createState() => _RoutinePageFinalState();
}

class _RoutinePageFinalState extends State<RoutinePageFinal> {
  TextEditingController _controller = TextEditingController();
  String newTaskTitle;
  bool _validate = false;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromRGBO(26, 28, 30, 0.6),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // height: 40.0,
                height: height * 0.075,
              ),
              Text(
                " Routine Name ",
                style: GoogleFonts.inter(
                    fontSize: height * 0.038,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                // height: 20.0,
                height: height * 0.035,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 38.0),
                child: Container(
                  width: width * 0.80,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(54, 54, 54, 1.0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextField(
                    controller: _controller,
                    onChanged: (newText) {
                      newTaskTitle = newText;
                    },
                    style: TextStyle(
                      fontSize: 17.0,
                      height: 2.0,
                      color: Color.fromRGBO(255, 255, 255, 1.0),
                    ),
                    decoration: InputDecoration(
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      filled: true,
                      hintText: "Type Something...",
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                // height: 20.0,
                height: height * 0.035,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 38.0),
                child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: height * 0.55,
                    width: width * 0.80,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(54, 54, 54, 1.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: [
                        RoutineNameValues(
                          txtValue: "Ceiling Tv ",
                        ),
                        RoutineNameValues(
                          txtValue: "Ac ",
                        ),
                        RoutineNameValues(
                          txtValue: "Tv ",
                        ),
                        RoutineNameValues(
                          txtValue: "Fan ",
                        ),
                        RoutineNameValues(
                          txtValue: "Home Theatre ",
                        ),
                        RoutineNameValues(
                          txtValue: "Night Lamp ",
                        ),
                        RoutineNameValues(
                          txtValue: "Vaccum Cleaner ",
                        ),
                      ],
                    )),
              ),
              SizedBox(
                // height: 20.0,
                height: height * 0.035,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 38.0),
                child: Container(
                  height: height * 0.070,
                  width: width * 0.80,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(247, 179, 28, 1.0),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        if (newTaskTitle == null) {
                          showAlertDialog(context);
                        } else {
                          Provider.of<TaskData>(context, listen: false)
                              .addTask(newTaskTitle);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()),);
                          //  Navigator.popAndPushNamed(context, '/');
                          Navigator.pop(context);
                        }
                        setState(() {
                          _controller.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                        });
                      },
                      child: Text(
                        " Done ",
                        style: GoogleFonts.inter(
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Invalid declaration"),
      content: Text("please fill Name and choose device."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}


class RoutineNameValues extends StatefulWidget {
  RoutineNameValues({this.txtValue});
  final String txtValue;



  @override
  _RoutineNameValuesState createState() => _RoutineNameValuesState();
}

class _RoutineNameValuesState extends State<RoutineNameValues> {
  bool buttonStatus = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    return Padding(
      padding:EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.txtValue,
            style: GoogleFonts.inter(
                fontSize: height * 0.018,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Switch(
              inactiveTrackColor: Colors.grey,
              activeColor: Colors.orange,
              thumbColor:
              MaterialStateProperty.all(Colors.orange),
              value: buttonStatus,
              onChanged: (bool value) {
                setState(() {
                  buttonStatus = value;
                });
              })
        ],
      ),
    );
  }
}

