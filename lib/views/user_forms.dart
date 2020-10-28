import 'package:fluter_crud/models/user.dart';
import 'package:fluter_crud/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['email'] = user.email;
      _formData['name'] = user.name;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Usuário'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                final isValid = _form.currentState.validate();
                if (isValid) {
                  setState(() {
                    _isLoading = true;
                  });
                  _form.currentState.save();
                  await Provider.of<Users>(context, listen: false).put(
                    User(
                      id: _formData['id'],
                      name: _formData['name'],
                      email: _formData['email'],
                      avatarUrl: _formData['avatarUrl'],
                    ),
                  );
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _formData['name'],
                        decoration: InputDecoration(
                          labelText: 'nome',
                        ),
                        //validator: (value) {
                        //if (value == null || value.isEmpty) {
                        //return 'Digite um nome valido';
                        //}
                        //},
                        onSaved: (value) => _formData['name'] = value,
                      ),
                      TextFormField(
                        initialValue: _formData['email'],
                        decoration: InputDecoration(
                          labelText: 'email',
                        ),
                        onSaved: (value) => _formData['email'] = value,
                      ),
                      TextFormField(
                        initialValue: _formData['avatarUrl'],
                        decoration: InputDecoration(
                          labelText: 'Url do Avatar',
                        ),
                        onSaved: (value) => _formData['avatarUrl'] = value,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
