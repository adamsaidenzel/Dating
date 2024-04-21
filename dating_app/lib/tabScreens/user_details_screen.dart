import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/accountSettingScreen/account_settings_screen.dart';
import 'package:dating_app/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

class UserDetailsScreen extends StatefulWidget
{
  String? userID;

  UserDetailsScreen({super.key, this.userID,});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}



class _UserDetailsScreenState extends State<UserDetailsScreen>
{
  //personal info
  String name = '';
  String age = '';
  String phoneNo = '';
  String city = '';
  String country = '';
  String profileHeading = '';
  String lookingForInaPartner = '';

  //Appearance
  String height = '';
  String weight = '';
  String bodyType = '';

  //Life style
  String drink = '';
  String smoke = '';
  String martialStatus = '';
  String haveChildren = '';
  String noOfChildren = '';
  String profession = '';
  String employmentStatus = '';
  String income = '';
  String livingSituation = '';
  String willingToRelocate = '';
  String relationshipYouAreLookingFor = '';

  //Background - Cultural Values
  String nationality = '';
  String education = '';
  String languageSpoken = '';
  String religion = '';
  String ethnicity = '';

  //slider images
  String urlImage1 = "https://firebasestorage.googleapis.com/v0/b/dating-app-88e50.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=c8524daf-6c56-4f02-99dc-00c971c2f07c";
  String urlImage2 = "https://firebasestorage.googleapis.com/v0/b/dating-app-88e50.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=c8524daf-6c56-4f02-99dc-00c971c2f07c";
  String urlImage3 = "https://firebasestorage.googleapis.com/v0/b/dating-app-88e50.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=c8524daf-6c56-4f02-99dc-00c971c2f07c";
  String urlImage4 = "https://firebasestorage.googleapis.com/v0/b/dating-app-88e50.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=c8524daf-6c56-4f02-99dc-00c971c2f07c";
  String urlImage5 = "https://firebasestorage.googleapis.com/v0/b/dating-app-88e50.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=c8524daf-6c56-4f02-99dc-00c971c2f07c";

  retrieveUserInfo() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userID)
        .get()
        .then((snapshot)
    {
      if(snapshot.exists)
      {
        if(snapshot.data()!["urlImage1"] != null)
        {
          setState(() {
            urlImage1 = snapshot.data()!["urlImage1"];
            urlImage2 = snapshot.data()!["urlImage2"];
            urlImage3 = snapshot.data()!["urlImage3"];
            urlImage4 = snapshot.data()!["urlImage4"];
            urlImage5 = snapshot.data()!["urlImage5"];
          });
        }

        setState(() {
          //personal info
          name = snapshot.data()!["name"];
          age = snapshot.data()!['age'].toString();
          phoneNo = snapshot.data()!['phoneNo'];
          city = snapshot.data()!['city'];
          country = snapshot.data()!['country'];
          profileHeading = snapshot.data()!['profileHeading'];
          lookingForInaPartner = snapshot.data()!['lookingForInaPartner'];

          //Appearance
          height = snapshot.data()!['height'];
          weight = snapshot.data()!['weight'];
          bodyType = snapshot.data()!['bodyType'];

          //Life style
          drink = snapshot.data()!['drink'];
          smoke = snapshot.data()!['smoke'];
          martialStatus = snapshot.data()!['martialStatus'];
          haveChildren = snapshot.data()!['haveChildren'];
          noOfChildren = snapshot.data()!['noOfChildren'];
          profession = snapshot.data()!['profession'];
          employmentStatus = snapshot.data()!['employmentStatus'];
          income = snapshot.data()!['income'];
          livingSituation = snapshot.data()!['livingSituation'];
          willingToRelocate = snapshot.data()!['willingToRelocate'];
          relationshipYouAreLookingFor = snapshot.data()!['relationshipYouAreLookingFor'];

          //Background - Cultural Values
          nationality = snapshot.data()!['nationality'];
          education = snapshot.data()!['education'];
          languageSpoken = snapshot.data()!['languageSpoken'];
          religion = snapshot.data()!['religion'];
          ethnicity = snapshot.data()!['ethnicity'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveUserInfo();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        //automaticallyImplyLeading: widget.userID == currentUserID ? false : true,
        leading: widget.userID != currentUserID ? IconButton(
          onPressed: ()
          {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_outlined, size: 30,),
        ) : Container(),
        actions: [
          widget.userID == currentUserID ?
          Row(
            children: [
              IconButton(
                onPressed: ()
                {
                  Get.to(AccountSettingsScreen());
                },
                icon: const Icon(
                  Icons.settings,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: ()
                {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                ),
              ),
            ],
          ) : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [

              //image slider
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Carousel(
                    indicatorBarColor: Colors.black.withOpacity(0.3),
                    autoScrollDuration: const Duration(seconds: 2),
                    animationPageDuration: const Duration(milliseconds: 500),
                    activateIndicatorColor: Colors.black,
                    animationPageCurve: Curves.easeIn,
                    indicatorBarHeight: 30,
                    indicatorHeight: 10,
                    indicatorWidth: 10,
                    unActivatedIndicatorColor: Colors.grey,
                    stopAtEnd: false,
                    autoScroll: true,
                    items: [
                      Image.network(urlImage1, fit: BoxFit.cover,),
                      Image.network(urlImage2, fit: BoxFit.cover,),
                      Image.network(urlImage3, fit: BoxFit.cover,),
                      Image.network(urlImage4, fit: BoxFit.cover,),
                      Image.network(urlImage5, fit: BoxFit.cover,),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10.0,),

              //personal info title
              const SizedBox(height: 30,),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Personal Info:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              //personal info table data
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [

                    //name
                    TableRow(
                      children:
                      [
                        const Text(
                          "Name: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),

                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    //extra row
                    const TableRow(
                      children:
                      [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //age
                    TableRow(
                      children:
                      [
                        const Text(
                          "Age: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),

                        Text(
                          age,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    //extra row
                    const TableRow(
                      children:
                      [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //phone No
                    TableRow(
                      children:
                      [
                        const Text(
                          "Phone Number: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),

                        Text(
                          phoneNo,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //city
                    TableRow(children :[
                      const Text(
                        "City: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        city,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //country
                    TableRow(children :[
                      const Text(
                        "Country: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        country,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //seeking
                    TableRow(children :[
                      const Text(
                        "Seeking: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        lookingForInaPartner,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                  ],
                ),
              ),

              //appearance title
              const SizedBox(height: 30,),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Appearance:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              //appearance table data
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [

                    //height
                    TableRow(children :[
                      const Text(
                        "Height: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        height,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Weight
                    TableRow(children :[
                      const Text(
                        "Weight: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        weight,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Body Type
                    TableRow(children :[
                      const Text(
                        "Body Type: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        bodyType,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                  ],
                ),
              ),

              //Life style title
              const SizedBox(height: 30,),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Life style:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              //Life style table data
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [

                    //Drink
                    TableRow(children :[
                      const Text(
                        "Drink: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        drink,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Smoke
                    TableRow(children :[
                      const Text(
                        "Smoke: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        smoke,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Martial Status
                    TableRow(children :[
                      const Text(
                        "Martial Status: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        martialStatus,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Have Children
                    TableRow(children :[
                      const Text(
                        "Have Children: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        haveChildren,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Number of Children
                    TableRow(children :[
                      const Text(
                        "Number of Children: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        noOfChildren,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Profession
                    TableRow(children :[
                      const Text(
                        "Profession: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        profession,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Employment Status
                    TableRow(children :[
                      const Text(
                        "Employment Status: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        employmentStatus,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Income
                    TableRow(children :[
                      const Text(
                        "Income: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        income,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Living Situation
                    TableRow(children :[
                      const Text(
                        "Living Situation: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        livingSituation,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Willing to Relocate
                    TableRow(children :[
                      const Text(
                        "Willing to Relocate: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        willingToRelocate,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Looking for
                    TableRow(children :[
                      const Text(
                        "Looking for: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        relationshipYouAreLookingFor,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                  ],
                ),
              ),

              //Background - Cultural Values title
              const SizedBox(height: 30,),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Background - Cultural Values:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              //Background - Cultural Values tables data
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [

                    //Nationality
                    TableRow(children :[
                      const Text(
                        "Nationality: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        nationality,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Education
                    TableRow(children :[
                      const Text(
                        "Education: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        education,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Language Spoken
                    TableRow(children :[
                      const Text(
                        "Language Spoken: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        languageSpoken,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Religion
                    TableRow(children :[
                      const Text(
                        "Religion: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        religion,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(children :[
                      Text(''),
                      Text(""),
                    ]),

                    //Ethnicity
                    TableRow(children :[
                      const Text(
                        "Ethnicity: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        ethnicity,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
