import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:dating_app/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController
{
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

  getResults()
  {
    onInit();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if(chosenGender == null || chosenCountry == null || chosenAge == null)
    {
      usersProfileList.bindStream(
          FirebaseFirestore.instance
              .collection("users")
              .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots()
              .map((QuerySnapshot queryDataSnapshot)
          {
            List<Person> profilesList = [];

            for(var eachProfile in queryDataSnapshot.docs)
            {
              profilesList.add(Person.fromDataSnapshot(eachProfile));
            }
            return profilesList;
          })
      );
    }
    else
    {
      usersProfileList.bindStream(
          FirebaseFirestore.instance
              .collection("users")
              .where("gender", isEqualTo: chosenGender.toString().toLowerCase())
              .where("country", isEqualTo: chosenCountry.toString())
              .where("age", isGreaterThanOrEqualTo: int.parse(chosenAge.toString()))
              .snapshots()
              .map((QuerySnapshot queryDataSnapshot)
          {
            List<Person> profilesList = [];

            for(var eachProfile in queryDataSnapshot.docs)
            {
              profilesList.add(Person.fromDataSnapshot(eachProfile));
            }
            return profilesList;
          })
      );
    }
  }

  favoriteSentAndFavoriteReceived(String toUserID, String senderName) async
  {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID).collection("favoriteReceived").doc(currentUserID)
        .get();

    //remove the favorite from database
    if(document.exists)
    {
      //remove currentUserID from the favoriteReceived list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID).collection("favoriteReceived").doc(currentUserID)
          .delete();

      //remove profile person [toUserID] from the favoriteSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID).collection("favoriteSent").doc(toUserID)
          .delete();
    }
    else //mark as favorite //add favorite in database
    {
      //add currentUserID to the favoriteReceived list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID).collection("favoriteReceived").doc(currentUserID)
          .set({});

      //add profile person [toUserID] to the favoriteSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID).collection("favoriteSent").doc(toUserID)
          .set({});

      //send notification
      sendNotificationToUser(toUserID, "Favorite", senderName);
    }

    update();
  }

  likeSentAndLikeReceived(String toUserID, String senderName) async
  {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID).collection("likeReceived").doc(currentUserID)
        .get();

    //remove the like from database
    if(document.exists)
    {
      //remove currentUserID from the likeReceived list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID).collection("likeReceived").doc(currentUserID)
          .delete();

      //remove profile person [toUserID] from the likeSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID).collection("likeSent").doc(toUserID)
          .delete();
    }
    else //add-sent like in database
        {
      //add currentUserID to the likeReceived list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID).collection("likeReceived").doc(currentUserID)
          .set({});

      //add profile person [toUserID] to the likeSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID).collection("likeSent").doc(toUserID)
          .set({});

      //send notification
      sendNotificationToUser(toUserID, "Like", senderName);
    }

    update();
  }

  viewSentAndViewReceived(String toUserID, String senderName) async
  {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID).collection("viewReceived").doc(currentUserID)
        .get();

    if(document.exists)
    {
      print("already in view list");
    }
    else //add new view in database
        {
      //add currentUserID to the viewReceived list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID).collection("viewReceived").doc(currentUserID)
          .set({});

      //add profile person [toUserID] to the viewSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID).collection("viewSent").doc(toUserID)
          .set({});

      //send notification
      sendNotificationToUser(toUserID, "View", senderName);
    }

    update();
  }

  sendNotificationToUser(receiverID, featureType, senderName) async
  {
    String userDeviceToken = "";

    await FirebaseFirestore.instance
        .collection("users")
        .doc(receiverID)
        .get()
        .then((snapshot)
    {
      if(snapshot.data()!["userDeviceToken"] != null)
      {
        userDeviceToken = snapshot.data()!["userDeviceToken"].toString();
      }
    });

    notificationFormat(
        userDeviceToken,
        receiverID,
        featureType,
        senderName,
    );
  }

  notificationFormat(userDeviceToken, receiverID, featureType, senderName,)
  {
    Map<String, String> headerNotification =
    {
      "Content-Type": "application/json",
      "Authorization": fcmServerToken,
    };

    Map bodyNotification =
    {
      "body": "you have received a new $featureType from $senderName. Click to see.",
      "title": "New $featureType",
    };

    Map dataMap =
    {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "userID": receiverID,
      "senderID": currentUserID,
    };

    Map notificationOfficialFormat =
    {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": userDeviceToken,
    };
    
    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(notificationOfficialFormat),
    );
  }
}