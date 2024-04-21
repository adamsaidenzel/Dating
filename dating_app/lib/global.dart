import 'package:firebase_auth/firebase_auth.dart';

String currentUserID = FirebaseAuth.instance.currentUser!.uid;
String? chosenAge;
String? chosenCountry;
String? chosenGender;
String fcmServerToken = "key=AAAAqx3AOoc:APA91bEEi_lRps90Q3nSfbC_Y_im2S34bUbboIBLh8v2ggmdVgZO3D5sr9b1GtdctyckTqnElFTwE-X9E-SE6Cc8REEzau-hjmuHPhQtnOkXiFYMTwYAoR0iVnsOaVbCkpIYaWbrJCKw";