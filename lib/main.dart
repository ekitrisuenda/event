import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_apps_with_api_mysql/list_page.dart';
import 'package:login_apps_with_api_mysql/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Animation/FadeAnimation.dart';


void main(){
  runApp(MaterialApp(
    home: Login(),
    theme: ThemeData(),
  ));
}

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState ();
}

enum LoginStatus {notSignIn, signIn}
LoginStatus _loginStatus = LoginStatus.notSignIn;
String username, password;
final _key = new GlobalKey<FormState>();
bool _secureText = true;

class _LoginState extends State <Login> {
  showHide(){
    setState((){
      _secureText = !_secureText;
    });
  }

  check(){
    final form = _key.currentState;
    if (form.validate()){
      form.save();
      login();
    }
  }

  login() async{
    final response = await http.post("http://apikelvin2019.000webhostapp.com/login.php",
        body: {"username" : username, "password" : password});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String user = data['username'];
    String nama = data['nama'];
    String id = data['id'];
    if (value == 1){
      setState((){
        _loginStatus = LoginStatus.signIn;
        savePref(value, user, nama, id);
      });
      print(message);
    }else{
      print(message);
    }
  }

  savePref(int value, String username, String nama, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState((){
      preferences.setInt("value", value);
      preferences.setString("nama", nama);
      preferences.setString("username", username);
      preferences.setString("id", id);
      preferences.commit();
    });
  }

  var value;

  getPref() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState((){
      value = preferences.getInt("value");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState((){
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState(){
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context){
    switch (_loginStatus){
      case LoginStatus.notSignIn:
        return Scaffold(
          appBar: AppBar(
            title: Text("Login"),
            backgroundColor: Color.fromRGBO(41, 203, 236, 1),
          ),
          body: Form(
            key: _key,
            child: ListView(
              children: <Widget>[
                Container(
                  height: 330,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        top: 25,
                        width: 80,
                        height: 120,
                        child: FadeAnimation(1, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/awan-1.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 120,
                        child: FadeAnimation(1.3, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/awan-2.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        right: 40,
                        top: 25,
                        width: 80,
                        height: 120,
                        child: FadeAnimation(1.5, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/awan-3.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        top: 250,
                        width: 80,
                        height: 80,
                        child: FadeAnimation(2.1, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/orang.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        left: 140,
                        top: 220,
                        width: 80,
                        height: 20,
                        child: FadeAnimation(2.2, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/sinyal-1.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        right: 1,
                        top: 250,
                        width: 80,
                        height: 15,
                        child: FadeAnimation(2.3, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/sinyal-2.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        top: 10,
                        left: 110,
                        width: 150,
                        height: 250,
                        child: FadeAnimation(1.3, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/Untitled-1.png')
                              )
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (e){
                          if (e.isEmpty){
                            return "Isi username terlebih dahulu";
                          }
                        },
                        onSaved: (e) => username = e,
                        decoration: InputDecoration(
                          labelText: "username",
                        ),
                      ),
                      TextFormField(
                          validator: (e){
                            if (e.isEmpty){
                              return "Isi password terlebih dahulu";
                            }
                          },
                          obscureText: _secureText,
                          onSaved: (e) => password = e,
                          decoration: InputDecoration(
                              labelText: "password",
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ))),
                      new Padding(padding: EdgeInsets.only(top: 8.0)),
                      RaisedButton(
                        onPressed: () {
                          check();
                        },
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text("Login"),
                      ),

                      new Padding(padding: EdgeInsets.only(top: 50.0)),

                      new Text(
                        "Eki Tri Suenda",
                        style: TextStyle(color: Colors.blue, fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),

                      new Text(
                        "Npm : 1717051057",
                        style: TextStyle(color: Colors.blue, fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return Dashboard(signOut);
        break;
    }
  }
}

class Dashboard extends StatefulWidget {
  final VoidCallback signOut;
  Dashboard(this.signOut);

  @override
  _DashboardState createState() => _DashboardState ();
}

class _DashboardState extends State<Dashboard>{
  signOut(){
    setState(() {
      widget.signOut();
    });
  }
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {});
  }
  @override
  void initState(){
    super.initState();
    getPref();
  }

  @override
  Widget build (BuildContext context){
    return Scaffold (
      appBar: AppBar(title: Text ("Dashboard"), leading : Icon(Icons.home)),
      body: new Container (
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("halo selamat datang di dashboard",
                style: new TextStyle(fontSize:20.0)),

            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              child: new Container(
                margin: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0),
                child: new RaisedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ListPage();
                    }));
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("7 Macam Event Seru"),
                ),
              ),
            ),

            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              child: new Container(
                margin: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0),
                child: new RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ProfilePage();
                      }));
                    },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Profil")),
              )
            ),

            ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                child: new Container(
                  margin: const EdgeInsets.all(16.0),
                  child: new RaisedButton(onPressed: () {
                    signOut();
                  },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text("Logout")),
                )),

          ],
        ),
      ),
    );
  }
}