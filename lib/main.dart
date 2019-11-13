import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app123/Helper/Validator.dart';
import 'package:toast/toast.dart';
import 'package:flutter_app123/SignUpPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("Inside Material");
    return MaterialApp(
      theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.deepOrange,
          primaryColorDark: Colors.deepOrange,
          accentColor: Colors.lightBlue[900],

          // Define the default font family.
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          )),
      debugShowCheckedModeBanner: false,

      home: MyHomePage(

          // title: appName,
          ),

//      home: Scaffold(
//        appBar: new AppBar(title: Text("Log In"),),
//        body: Column(
//          children: <Widget>[
//            Text("Hello"),
//         SizedBox(height: 10,),
//            Row(
//              children: <Widget>[
//                RaisedButton(
//
//                  child: Row(
//                    children: <Widget>[
//                      Icon(Icons.headset_mic),
//                      Text("Plug in")
//                    ],
//                  ),
//                ),
//                SizedBox(width: 20,),
//                MaterialButton(
//                  color: Colors.red,
//                  splashColor: Colors.green,
//                  padding: EdgeInsets.only(left: 0,right: 0),
//                  minWidth: 90,
//                  onPressed: () => {},
//                  child: Row(
//                    children: <Widget>[
//                      Icon(Icons.headset_mic),
//                      Text("Plug in")
//                    ],
//                  ),
//                ),
//              ],
//            ),
//            TextField(
//              decoration: InputDecoration(
//               border: new OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
//
//              ),
//            )
//          ],
//        )
//      ),
    );
  }
}

//appbar
class MyHomePage extends StatelessWidget {
  final String title = "Log In";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: MyCustomForm(

        ),
      ),
      // body: MyCustomForm(),
//      floatingActionButton: Theme(
//        data: Theme.of(context).copyWith(
//          colorScheme: Theme.of(context)
//              .colorScheme
//              .copyWith(secondary: Colors.deepOrange),
//        ),
//        child: FloatingActionButton(
//          onPressed: null,
//          child: Icon(Icons.add),
//        ),
//      ),
    );
  }
}

// Create a Form widget.body
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  LoginRequestData _loginData = LoginRequestData();
  bool _obscureText = true;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: new Container(
        margin: new EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Center(
              //margin: const EdgeInsets.only(left: 40),
              child: new Text(
                'Welcome ',
                textAlign: TextAlign.center,
                style: new TextStyle(color: Colors.deepOrange, fontSize: 25.0),
              ),
            ),

            //image: AssetImage('assets/images/profilebackgound.jpg')))
            new SizedBox(height: 20.0),
            new Center(
              child: new Image.asset(
                'assets/images/user.png',
                height: 100,
                width: 100,
              ),
            ),
            new SizedBox(height: 30.0),

            //     new Padding(padding: EdgeInsets.only(top: 50.0)),
            TextFormField(
              //obscureText: _obscureText,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,

              decoration: InputDecoration(
                labelText: 'Enter your Email',

                //hintText: ' Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
              ),
//              validator: (String arg) {
//                if(arg.length < 3)
//                  return 'Name must be more than 2 charater';
//                else
//                  return null;
//              },
//              onSaved: (String val) {
//                _loginData.email = val;
//              },

              // keyboardType: TextInputType.text,
              // obscureText: true
              // maxLength: 10,

//              validator: (value) {
//                if (value.isEmpty) {
//                  return 'Please enter some text';
//                }
//                return null;
//              },

              validator: validateEmail,
              onSaved: (String value) {
                _loginData.email = value;
              },
            ),
            new SizedBox(height: 20.0),

            new TextFormField(
                //obscureText: true,
                obscureText: _obscureText,
                //keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  //hintText: ' Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 0.0),
                  ),

                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      semanticLabel:
                          _obscureText ? 'show password' : 'hide password',
                    ),
                  ),
                ),

                // keyboardType: TextInputType.text,
                // obscureText: true
                // maxLength: 10,

                validator: validatePassword,
                onSaved: (String value) {
                  _loginData.password = value;
                }),

            new SizedBox(height: 25.0),

            ButtonTheme(
              minWidth: 16.0,
              height: 35.0,
              child: RaisedButton(
                onPressed: _validateInputs,
                //child: new Text('Validate'),
                //onPressed: () => print("submit"),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,

                  //`mainAxisAlignment: MainAxisAlignment.center` => Center Column contents vertically,
                  children: <Widget>[
                    new Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        'LogIn',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

//                    Icon(
//                      Icons.keyboard_arrow_down,
//                      size: 20.0,
//                    ),
                  ],
                ),
              ),
            ),
//            MaterialButton(
//              // padding: EdgeInsets.only(left: 20,right: 90),
//              minWidth: double.maxFinite,
//              // set minWidth to maxFinite
//              color: Colors.blue,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(10),
//              ),
//
//              onPressed: () {},
//              child: Text("LogIn"),
//            ),
            new Center(
              //margin: const EdgeInsets.only(top: 10.0, left: 40),

                child: new RaisedButton(
                  onPressed: null,
                  child: new Text('Login'),
                ),

            ),
//
//            new Padding(
//              padding: EdgeInsets.symmetric(vertical: 16.0),
//              child: RaisedButton(
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(24),
//                ),
//                onPressed: null,
//                padding: EdgeInsets.all(12),
//                color: Colors.lightBlueAccent,
//                child: Text('Log In', style: TextStyle(color: Colors.white)),
//              ),
//            ),

            new Center(
              child: new FlatButton(
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                onPressed: null,
              ),
            ),

            new Center(
              child: new FlatButton(
                onPressed: GetRegister,
                child: Text('Not a member? Sign up now',
                    style: TextStyle(color: Colors.black54)),
              ),
            ),

//    Padding(
//    padding: const EdgeInsets.symmetric(vertical: 16.0),
//    child: RaisedButton(
//    onPressed: () {
//    // Validate returns true if the form is valid, or false
//    // otherwise.
//    if (_formKey.currentState.validate()) {
//    // If the form is valid, display a Snackbar.
//    Scaffold.of(context).showSnackBar(
//    SnackBar(content: Text('Processing Data')));
//    }
//    },
//    child: Text('Submit'),
//    ),
          ],
        ),
      ),
    );
  }

  void GetRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      print("Validate");
      Toast.show("Validate Succsses", context,
          backgroundColor: Colors.deepOrange,
          textColor: Colors.white,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}

class LoginRequestData {
  String email = '';
  String password = '';
}

String validatePassword(String value) {
  Pattern pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = new RegExp(pattern);
  print(value);
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value))
      return 'Enter valid password';
    else
      return null;
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.isEmpty) {
    return "Email is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}
