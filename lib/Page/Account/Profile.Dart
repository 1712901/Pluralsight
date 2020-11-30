import 'package:Pluralsight/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController userNameController;

  TextEditingController emailController;

  bool isEdit = false;

  @override
  void initState() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    userNameController.text = user.name;
    emailController.text = user.email;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profile'),
        actions: [
          IconButton(
              icon: Icon(isEdit ? Icons.check : Icons.edit),
              onPressed: () {
                if (isEdit) {
                  //Update Proflie
                  user.setProfile(
                      name: userNameController.text,
                      email: emailController.text);
                }
                setState(() {
                  isEdit = !isEdit;
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: ClipOval(
                    child: Container(
                      color: Colors.orange[300],
                    ),
                  ),
                ),
              ),
              TextField(
                enabled: isEdit,
                controller: userNameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.grey[600])),
              ),
              TextField(
                enabled: isEdit,
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[600])),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                    borderSide: BorderSide(color: Colors.blue),
                    onPressed: () {
                      user.logout();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Log out',
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
