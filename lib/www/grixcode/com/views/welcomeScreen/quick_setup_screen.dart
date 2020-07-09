import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/validator/auth_validator.dart';
import 'package:girixscanner/www/grixcode/com/views/homeScreen/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class QuickSetup extends StatefulWidget {
  @override
  _QuickSetupState createState() => _QuickSetupState();
}

class _QuickSetupState extends State<QuickSetup> with AuthValidation {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _reset() {
    _emailController.text = "";
    _fullNameController.text = "";
  }

  void _next(MainModel mainModel) async {
    if (!_formKey.currentState.validate()) return;
    mainModel.saveToDevice(
        email: _emailController.text, username: _fullNameController.text);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => HomeScreen(
                  model: mainModel,
                )));
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      autofocus: false,
      decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
        labelText: "Email",
        labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87),
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 18.6,
        ),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(2)),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _fullNameController,
      keyboardType: TextInputType.text,
      validator: usernameValidator,
      autofocus: false,
      decoration: InputDecoration(
//              prefixIcon: Icon(Icons.person),
        labelText: "Username",
        labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87),
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 18.6,
        ),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(2)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black87,
              ),
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "Make a quick setup",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      height: 135.0,
                      width: 135.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/profile_pic.png"),
                              fit: BoxFit.cover)),
                      child: Container()),
                  SizedBox(
                    height: 25,
                  ),
                  _buildNameField(),
                  SizedBox(
                    height: 25,
                  ),
                  _buildEmailField(),
                  SizedBox(
                    height: 45.0,
                  ),
                  Container(
                    alignment: Alignment.center,
//                padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: ScopedModelDescendant(
                      builder: (_, __, MainModel model) {
                        return MaterialButton(
                          onPressed: () => _next(model),
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          textColor: Colors.white,
                          elevation: 0.0,
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text("NEXT"),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
