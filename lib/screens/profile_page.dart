
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/providers/user_provider.dart';
import 'package:wheather_app/screens/edit_page.dart';
import 'package:wheather_app/utilities/utils.dart';

class ProfilePage extends StatefulWidget{

  const ProfilePage({super.key}) ;

  @override
  State<ProfilePage> createState() => _ProfilePageState() ;

}

class _ProfilePageState extends State<ProfilePage> {

  Uint8List? _image ;

  void selectImage() async {
    // Uint8List img = await pickImage(ImageSource.gallery) ;
    setState(() {
      // _image = img ;
    });
  }

  Widget build(BuildContext context){
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
        body: Container(
          color: const Color.fromARGB(255, 68, 71, 255),
          child: Center(
            child: Column(
                children: [
                  SizedBox(height: 100 ,),
                  Stack(
                    children: [ CircleAvatar(
                      backgroundImage: NetworkImage("https://www.telework.ro/wp-content/uploads/2022/08/blank-profile-picture-973460-anonymous-avatar.jpg"),
                      maxRadius: 80,
                    ),
                    Positioned(bottom: -10, left: 100,child: IconButton(onPressed: selectImage, icon: const Icon(Icons.add_a_photo), ))
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text("${user!.firstName} ${user.lastName}" , style: TextStyle(
                    color: Colors.white , 
                    fontSize: 30
                  ),) ,
                  SizedBox(height: 10,),
                  Text("${user.country}, ${user.city}", style: TextStyle(
                    color: Colors.white , 
                    fontSize: 30
                  )
                  ),
                  SizedBox(height: 10,), 
                  ElevatedButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage()));}, child: Text("Edit") , style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent ,
                foregroundColor: Colors.white, 
                minimumSize: Size(200, 30),  
              ),),
                SizedBox(height: 200,) ,
                ElevatedButton(onPressed: (){
                  Navigator.pop(context) ;
                }, child: Text("Back to Home") , style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent ,
                foregroundColor: Colors.white, 
                minimumSize: Size(200, 30),  
              ),),
                ],
            ),
          ),
        )
    );
  }

}