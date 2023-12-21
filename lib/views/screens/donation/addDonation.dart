import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/donationField.dart';
import 'package:food_donation_app/controller/LocationManager.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/controller/donationController.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:provider/provider.dart';

class AddDonation extends StatefulWidget {
  const AddDonation({super.key});

  @override
  State<AddDonation> createState() => _AddDonationState();
}

class _AddDonationState extends State<AddDonation> {
  final productController = TextEditingController();
  final qtyController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productController.dispose();
    qtyController.dispose();
  }

  // final date = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime dateRef = DateTime.now();
  final _formKey = GlobalKey<FormState>();
   String status = 'active';
   var preprationTime;
  @override
  Widget build(BuildContext context) {
    // final hours = timeOfDay.hour.toString().padLeft(2, '0');
    // final minutes = timeOfDay.minute.toString().padLeft(2, '0');
    final provider = Provider.of<DonationController>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Donation',
          style: Heading1.copyWith(fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () async {
                 final TimeOfDay? prepTime = await showTimePicker(
                      context: context, initialTime: timeOfDay);
                  if (prepTime != null) {
                    setState(() {
                      timeOfDay = prepTime;
                      preprationTime = timeOfDay.hour;
                      // preprationTime!.format(context);
                    });
                    return;
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      // border:Border.all(width: 1, color: mainColor)
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Prepration Time:',
                        style: paragraph.copyWith(color: mainColor),
                      ),
                      Text(
                        '${timeOfDay.hour}:${timeOfDay.minute}',
                        style:
                            paragraph.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex :2,
                    child: DonationField(
                  controller: productController,
                  keyboardType: TextInputType.text,
                  validator: (value) {},
                  label: 'Items',
                )),
                SizedBox(width: 6,),
                Expanded(
                    child: DonationField(
                      controller: qtyController,
                      keyboardType: TextInputType.number,
                      validator: (value) {},
                      label: 'Quantity',
                    ))
              ],
            )

            // Aligns(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       'Added Items',
            //       style: Heading3.copyWith(fontSize: 18, color: textColor),
            //     )),
            // Expanded(
            //     child: ListView.builder(
            //         itemCount: _list.length,
            //
            //         // itemCount: provider.list.length,
            //         itemBuilder: (context, index) {
            //           // final String? dateTimeRef = _list[index]['date'] +", "+ _list[index]['time'];
            //           return Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 4),
            //             child: ListTile(
            //               onTap: () {
            //                 setState(() {
            //                   _list.removeAt(index);
            //                 });
            //               },
            //               shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(12)),
            //               tileColor: Colors.grey.withOpacity(0.1),
            //               title: Text(
            //                 _list[index]['product'],
            //                 style: paragraph.copyWith(
            //                     color: Colors.green, fontSize: 16),
            //               ),
            //               // subtitle: Text(dateTimeRef.toString()),
            //               trailing: Text(_list[index]['quantity'],
            //                   style: paragraph.copyWith(fontSize: 16)),
            //             ),
            //           );
            //         })),
            ,
            SizedBox(
              height: 10,
            ),
            GradientButton(
                label: 'Donate',
                onPress: () {
                  FirebaseFirestore.instance
                      .collection('donations')
                      .add({
                    'id' : FirebaseAuth.instance.currentUser!.uid,
                    'donated by': FirebaseAuth.instance.currentUser!.displayName,
                    'status': status,
                    'date': dateRef,
                    'prep time': timeOfDay.hour,
                    "item": productController.text,
                    'quantity': qtyController.text,
                    'location': LocationManager().local.toString()
                  }).then((value) {
                    Utils.toastMessage("Donation added!", Colors.green);

                    productController.clear();
                    qtyController.clear();
                 }).onError((error, stackTrace){
                    Utils.toastMessage(error.toString(), Colors.red);

                  });

                },
                loading: provider.loading),
          
          ],
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateRef,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: timeOfDay.hour, minute: timeOfDay.minute));
}
