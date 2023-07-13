import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../screens/go_premium_pkgs.dart';
import '../screens/pettypass_screen.dart';
import 'custom_button.dart';

class CustomContainer extends StatelessWidget {
  final txt1;
  final txt2;
  final img;

  const CustomContainer({
    this.img,
    @required this.txt1,
    @required this.txt2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.topLeft,
        height: 155,
        width: 380,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(26, 255, 60, 125),
          ),
          borderRadius: BorderRadius.circular(10),
          // color: Color(0x1AFF4181),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoPremiumPkgs()));
                  },
                  child: SvgPicture.asset(
                    img,
                    width: 60,
                    height: 90,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      txt1,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(txt2)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBUtton(
                      onprs: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PettyPassScreen()));
                      },
                      BText: 'Buy',
                      color: Colors.blue,
                      bgColor: Colors.white,
                      foreGcolor: Colors.white,
                      txtclr: Colors.blue),
                  CustomBUtton(
                    onprs: () {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => pettyPassActivate()));
                    },
                    BText: 'Activate Now',
                    color: Colors.green,
                    bgColor: Colors.green,
                    foreGcolor: Colors.green,
                    txtclr: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
