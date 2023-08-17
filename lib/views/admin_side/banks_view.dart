import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/admin_side/ad_uploading_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BanksView extends StatefulWidget {
  const BanksView({Key? key, required this.id, this.isAd = false})
      : super(key: key);
  final String id;
  final bool? isAd;

  @override
  State<BanksView> createState() => _BanksViewState();
}

class _BanksViewState extends State<BanksView> {
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
        appBar: AppBar(
          actions: [
            if (!widget.isAd!)
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => AddBankSheet(
                        regionId: widget.id,
                      ),
                    );
                  },
                  icon: Icon(Icons.add))
          ],
          elevation: 0.0,
          backgroundColor: kPrimary,
          title: Text(
            'Region\'s Banks',
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
                      trailing:
                      widget.isAd!? IconButton(
                        onPressed: () {
                          Get.to(AdUploadingScreen(bankId: document.id));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ):
                      IconButton(
                        onPressed: () async {
                          try {
                            var reference = FirebaseFirestore.instance
                                .collection('Regions')
                                .doc(widget.id)
                                .collection("banks")
                                .doc(document.id);

                            await reference.delete();
                          } catch (e) {
                         Services.errorMessage(e.toString());
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 16,
                        ),
                      )
                      //subtitle: Text(data['company']),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ));
  }
}

class AddBankSheet extends StatefulWidget {
  const AddBankSheet({Key? key, required this.regionId}) : super(key: key);
  final String regionId;

  @override
  State<AddBankSheet> createState() => _AddBankSheetState();
}

class _AddBankSheetState extends State<AddBankSheet> {
  final TextEditingController bankNameController = TextEditingController();
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text(
              'Add Bank',
              style: TextStyle(
                fontFamily: AppFonts.montserratBold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            CustomTextField1(
              controller: bankNameController,
              // isPassword: true,
              hint: "Bank name",
              //    maxCharacters: 20,
              // validator: (v) => _authController.validatePassword(v!),
              margin: getMargin(left: 10, right: 10),
            ),
            SizedBox(height: 16.0),
            isUploading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                    ),
                    onPressed: () async {
                      if (bankNameController.text.isNotEmpty) setState(() {});
                      isUploading = true;
                      try {
                        await addBank(widget.regionId, bankNameController.text);

                        isUploading = false;
                        Get.back();
                        setState(() {});
                      } catch (e) {
                        isUploading = false;
                        Services.errorMessage(e.toString());
                        setState(() {});
                      }
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontFamily: AppFonts.montserratBold,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> addBank(String regionId, String bank) async {
    CollectionReference reference = FirebaseFirestore.instance
        .collection('Regions')
        .doc(regionId)
        .collection("banks");
    try {
      reference.add({"name": bank});
    } on FirebaseException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
