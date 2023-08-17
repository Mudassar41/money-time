import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/admin_side/banks_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegionsView extends StatefulWidget {
  const RegionsView({Key? key}) : super(key: key);

  @override
  State<RegionsView> createState() => _RegionsViewState();
}

class _RegionsViewState extends State<RegionsView> {
  final Stream<QuerySnapshot> regionsStream =
      FirebaseFirestore.instance.collection('Regions').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kPrimary,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => AddRegionSheet(),
                  );
                },
                icon: Icon(Icons.add))
          ],
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
                          Get.to(BanksView(id: document.id));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ),
                      leading: InkWell(
                          onTap: () async {
                            try {
                              var reference = FirebaseFirestore.instance
                                  .collection('Regions')
                                  .doc(document.id);

                              await reference.delete();
                            } catch (e) {
                              Services.successMessage(e.toString());
                            }
                          },
                          child: Icon(Icons.delete)),

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

class AddRegionSheet extends StatefulWidget {
  const AddRegionSheet({Key? key}) : super(key: key);

  @override
  State<AddRegionSheet> createState() => _AddRegionSheetState();
}

class _AddRegionSheetState extends State<AddRegionSheet> {
  final TextEditingController regionNameController = TextEditingController();
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
              'Add Region',
              style: TextStyle(
                fontFamily: AppFonts.montserratBold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            CustomTextField1(
              controller: regionNameController,
              // isPassword: true,
              hint: "Region name",
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
                      if (regionNameController.text.isNotEmpty) setState(() {});
                      isUploading = true;
                      try {
                        await addRegion(regionNameController.text);

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

  Future<void> addRegion(String region) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('Regions');

    try {
      reference.add({"name": region});
    } on FirebaseException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
