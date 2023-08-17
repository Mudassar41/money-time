import 'package:atm_tracker/controllers/user_controller.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:atm_tracker/views/user_side/custom_widgets/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'banks_list_screen.dart';

class ParishSelectionScreen extends StatelessWidget {
  final _userController = Get.put(UserController());
  final Stream<QuerySnapshot> regionsStream =
      FirebaseFirestore.instance.collection('Regions').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAppBar(),
            LargeText(
              text: "SELECT YOUR REGION",
              color: kWhite,
              fontFamily: AppFonts.montserratBold,
              size: getFontSize(24),
              margin: getMargin(left: 20, bottom: 2),
            ),
            CustomContainer(
              width: Get.width * 0.6,
              height: getVerticalSize(3),
              child: SizedBox(),
              isBorderRadius: true,
              color: kGrey,
              isShadow: false,
              margin: getMargin(left: 20),
            ),

            StreamBuilder<QuerySnapshot>(
              stream: regionsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                _userController.parishName.value = data['name'];
                                Get.to(() => BanksListScreen(
                                      parishName:
                                          _userController.parishName.value,
                                      id: document.id,
                                    ));
                                //  });
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                            ),

                            //subtitle: Text(data['company']),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            )
            // if (_userController.isLoading.value)
            //   Expanded(
            //       child:
            //           Center(child: CircularProgressIndicator(color: kWhite)))
            // else if (_userController.parishMap.entries.isEmpty)
            //   Expanded(
            //     child: Center(
            //       child: SmallText(
            //         text: "No Regions",
            //         color: kWhite,
            //         fontFamily: AppFonts.montserratRegular,
            //       ),
            //     ),
            //   )
            // else
            //   Expanded(
            //     child: ListView(
            //       padding: getPadding(left: 20, right: 20),
            //       children: [
            //         ..._userController.parishMap.entries.map((e) {
            //           return BankNameTile(
            //               name: e.key,
            //               onTap: () {
            //                 _userController.parishName.value = e.key;
            //                 Get.to(() => BanksListScreen(
            //                       parishName: _userController.parishName.value,
            //                     ));
            //               });
            //         })
            //       ],
            //     ),
            //   )
          ],
        ),

    );
  }
}
