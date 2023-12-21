import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/Role_manager.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/donation/donationDetails.dart';

class CardContiner extends StatelessWidget {
  final String item, quantity, restaurentName, address, status;
  final int time;
  final VoidCallback onTap;
  const CardContiner(
      {super.key,
      required this.item,
      required this.quantity,
      required this.restaurentName,
      required this.time,
      required this.address,
      required this.status, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final String image = 'asset/food.jpg';
    final String preptime = '${DateTime.now().hour - time} hours ago';
    final String serving = '$quantity people';
    final String restaurant = restaurentName;
    final String location = address;

    return Padding(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
          onTap: () {
            if (RoleController().role == 'Restaurant') {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 30,
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: onTap,
                                child: Text(
                                  'Delete',
                                  style: paragraph.copyWith(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
            if (RoleController().role == 'NGO') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DonationDetails(
                            img: image,
                            item: item,
                            restaurant: restaurant,
                            prepTime: preptime,
                            serving: serving,
                            location: location,
                          )));
            }
            return print('role is null');
          },
          child: Container(
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: Image(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8)),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item,
                                style: Heading3.copyWith(fontSize: 18),
                              ),
                            ),
                            RoleController().role == 'NGO'
                                ? Container()
                                : Expanded(
                                    child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: status == 'active'
                                                  ? Colors.green.shade100
                                                  : Colors.yellow.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text(
                                            status,
                                            textAlign: TextAlign.right,
                                          )),
                                    ),
                                  ))
                          ],
                        ),
                        Text(
                          restaurentName,
                          style: paragraph.copyWith(color: Colors.black),
                        ),
                        RichText(
                            text: DateTime.now().hour - time < 0
                                ? TextSpan(
                                    text: 'Will prepare in: ',
                                    children: [
                                      TextSpan(
                                          text:
                                              ' ${(DateTime.now().hour - time) * -1} hour',
                                          style: paragraph.copyWith(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ],
                                    style: paragraph.copyWith(
                                        color: mainColor, fontSize: 14))
                                : TextSpan(
                                    text: 'Prepared:',
                                    children: [
                                      TextSpan(
                                          text:
                                              ' ${DateTime.now().hour - time} hours ago',
                                          style: paragraph.copyWith(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ],
                                    style: paragraph.copyWith(
                                        color: mainColor, fontSize: 14))),
                        RichText(
                            text: TextSpan(
                                text: 'For:',
                                children: [
                                  TextSpan(
                                      text: ' $quantity people',
                                      style: paragraph.copyWith(
                                          color: Colors.black, fontSize: 14)),
                                ],
                                style: paragraph.copyWith(
                                    color: mainColor, fontSize: 14))),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
