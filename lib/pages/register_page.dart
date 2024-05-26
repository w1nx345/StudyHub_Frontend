import 'package:flutter/material.dart';
import 'package:learn_hub/pages/login_page.dart';
import 'package:learn_hub/shared_register.dart/shared.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Hub',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor
      ),
      home: const MyHomePage(title: 'Study Hub'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _dateController = TextEditingController();

  Future<void> _dateTime() async{
    DateTime? _picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(1945), 
      lastDate: DateTime(2045),
    );

    if(_picked != null){
      setState((){
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

 @override
 Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('../images/Study Hub Logo.png'),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(

                    labelText: 'E-mail :',
                    labelStyle: TextStyle(color: Colors.white, fontFamily: "OpenSans-ExtraBold"),
          

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),  
                  ),
                ),
                SizedBox(height: 10),

                TextField(
                  controller: _dateController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(

                    labelText: 'Date of Birth :',
                    labelStyle: TextStyle(color: Colors.white, fontFamily: "OpenSans-ExtraBold"),
                    filled: false,
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.white
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  readOnly: true,
                  onTap: (){
                    _dateTime();
                  },
                ),
                SizedBox(height: 10),

                TextField(
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password :',
                    labelStyle: TextStyle(color: Colors.white, fontFamily: "OpenSans-ExtraBold"),
              
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => LoginPage(), //ini menuju ke login page harusnya, detail page untuk test
                        ));
                  },
                  child: const Text("Join Now"),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0x241E90)),foregroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    ),
  );
 }
}