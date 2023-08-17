import 'package:atm_tracker/controllers/user_controller.dart';
import 'package:atm_tracker/utils/constant/strings.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/views/user_side/bank_details_screen.dart';
import 'package:atm_tracker/views/user_side/custom_widgets/bank_name_tile.dart';
import 'package:atm_tracker/views/user_side/custom_widgets/user_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BanksListScreen extends StatefulWidget {
  final String parishName;
  final String id;

  BanksListScreen({required this.parishName, required this.id});

  @override
  State<BanksListScreen> createState() => _BanksListScreenState();
}

class _BanksListScreenState extends State<BanksListScreen> {
  final _userController = Get.find<UserController>();
  late Stream<QuerySnapshot> regionsStream;

  @override
  void initState() {
    super.initState();
    regionsStream = FirebaseFirestore.instance
        .collection('Regions')
        .doc(widget.id)
        .collection('banks')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAppBar(),
          LargeText(
              text: "BANKS",
              color: kWhite,
              fontFamily: AppFonts.montserratBold,
              size: getFontSize(24),
              margin: getMargin(left: 20, bottom: 2)),
          CustomContainer(
            width: Get.width * 0.6,
            height: getVerticalSize(3),
            child: SizedBox(),
            isBorderRadius: true,
            color: kGrey,
            isShadow: false,
            margin: getMargin(left: 20),
          ),
          SmallText(
            text: widget.parishName,
            color: kWhite,
            margin: getMargin(left: 20),
            fontFamily: AppFonts.montserratRegular,
          ),
          SizedBox(height: 5),

          StreamBuilder<QuerySnapshot>(
            stream: regionsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
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
                                _userController.bankName.value=data['name'];
                                _userController.getFilteredList();
                                Get.to(
                                  () => BankDetailsScreen(
                                    bankName: data['name'],
                                    bankId: document.id,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                            )
                            //subtitle: Text(data['company']),
                            ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          )

          // Expanded(
          //   child: ListView.builder(
          //     padding: getPadding(left: 20, right: 20, bottom: 20),
          //     itemCount: banksList.length,
          //     itemBuilder: (context, index) {
          //       return BankNameTile(
          //           name: banksList[index],
          //           onTap: () {
          //             _userController.bankName.value = banksList[index];
          //             _userController.getFilteredList();
          //
          //             Get.to(
          //               () => BankDetailsScreen(
          //                 bankName: banksList[index],
          //                 bankId: 'index',
          //               ),
          //             );
          //           });
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
