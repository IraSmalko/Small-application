import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_application/bloc/bloc.dart';
import 'package:small_application/models/user.dart';

startInsertUserScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => _InsertUserScreen(),
    ),
  );
}

class _InsertUserScreen extends StatefulWidget {
  @override
  _InsertUserScreenState createState() => _InsertUserScreenState();
}

class _InsertUserScreenState extends State<_InsertUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameNode = FocusNode();
  final _carNode = FocusNode();
  final _ageNode = FocusNode();

  TextEditingController _nameController;
  TextEditingController _carController;
  TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _nameNode.attach(context);
    _carNode.attach(context);
    _ageNode.attach(context);

    _nameController = TextEditingController();
    _carController = TextEditingController();
    _ageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameNode.dispose();
    _carNode.dispose();
    _ageNode.dispose();

    _nameController.dispose();
    _carController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              inputSection,
              SizedBox(height: 24),
              insertButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget get inputSection {
    const errorStyle = TextStyle(color: const Color(0xFFff5353), fontSize: 12);

    const focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.pinkAccent,
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(const Radius.circular(24.0)),
    );

    const enabledBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: const Color(0xFFe7e7e7),
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(const Radius.circular(24.0)),
    );

    const errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: const Color(0xFFff5353),
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(const Radius.circular(24.0)),
    );

    var validator = (value) {
      if (value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    };

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            focusNode: _nameNode,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              filled: true,
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
              labelText: 'Name',
              errorStyle: errorStyle,
              fillColor: Colors.white,
              focusColor: Colors.white,
            ),
            validator: validator,
            onFieldSubmitted: (term) {
              FocusScope.of(context).requestFocus(_carNode);
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _carController,
            focusNode: _carNode,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            decoration: InputDecoration(
              errorMaxLines: 3,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
              labelText: 'Car',
              errorStyle: errorStyle,
              fillColor: Colors.white,
              focusColor: Colors.white,
            ),
            validator: validator,
            onFieldSubmitted: (term) {
              FocusScope.of(context).requestFocus(_ageNode);
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _ageController,
            focusNode: _ageNode,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            cursorColor: const Color(0xFF1f7eff),
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              errorMaxLines: 3,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
              labelText: 'Age',
              errorStyle: errorStyle,
              fillColor: Colors.white,
              focusColor: Colors.white,
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }

  Widget get insertButton {
    return FlatButton(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      color: Colors.pinkAccent,
      child: Center(
        child: Text(
          'Insert',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          DataBloc.of(context).add(
            Insert(
              user: User(
                id: null,
                name: _nameController.text,
                age: int.parse(_ageController.text),
                car: _carController.text,
              ),
            ),
          );
          Navigator.pop(context);
        }
      },
    );
  }
}
