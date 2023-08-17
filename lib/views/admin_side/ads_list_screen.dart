import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/views/admin_side/banks_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsListScreen extends StatefulWidget {
  const AdsListScreen({Key? key}) : super(key: key);

  @override
  State<AdsListScreen> createState() => _AdsListScreenState();
}

class _AdsListScreenState extends State<AdsListScreen> {
  final Stream<QuerySnapshot> regionsStream =
      FirebaseFirestore.instance.collection('Regions').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kPrimary,
          title: Text(
            'Regions',
            style: TextStyle(
              fontFamily: AppFonts.montserratBold,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: regionsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      title: Text(
                        data['name'],
                        style: TextStyle(
                          fontFamily: AppFonts.montserratRegular,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Get.to(BanksView(id: document.id,
                                            isAd:true,

                          ));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ));
  }
}
