import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';

class DonationDetails extends StatefulWidget {
  final String img, item, restaurant, prepTime, serving, location ;

  const DonationDetails(
      {super.key,
      required this.img,
      required this.item,
      required this.restaurant,
      required this.prepTime,
      required this.serving, required this.location,});

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,

            decoration: BoxDecoration(
                color: Colors.grey.shade100,
              image: DecorationImage(image: AssetImage('././asset/food.jpg',), fit: BoxFit.cover)
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Donation Details',
              style: paragraph.copyWith(fontSize: 26, fontWeight: FontWeight.w600, color: mainColor),textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Column(children: [
              ReusableRow(title: 'Item Name', text: widget.item,),
              ReusableRow(title: 'Serving', text: widget.serving,),
              ReusableRow(title: 'Prepared Time', text: widget.prepTime,),
              ReusableRow(title: 'Donated By', text: widget.restaurant,),
              ReusableRow(title: 'location', text: widget.location,),


            ],),),

    ] ),
    );

  }

}
class ReusableRow extends StatelessWidget {
  final String title, text;
  const ReusableRow({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [Expanded(child: Text(title, style: paragraph.copyWith(fontSize: 18),textAlign: TextAlign.left,)),Expanded(child: Text(text, textAlign: TextAlign.right,style: paragraph,))],
          ),
        ),
        Divider()
      ],
    );
  }
}


