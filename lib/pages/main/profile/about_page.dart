import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class setting {
  String _name, _desc;
  IconData _image;
  Function _onTap;

  setting(this._name, this._desc, this._image, this._onTap);

  Function get onTap => _onTap;

  IconData get image => _image;

  get desc => _desc;

  String get name => _name;
}

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  List<setting> list = [
    setting(
      'About',
      'About us',
      Icons.info,
      () {},
    ),
    setting(
      'Terms of Use',
      'Terms and conditions',
      FontAwesomeIcons.fileContract,
      () {},
    ),
    setting(
      'Privacy policy',
      'read',
      Icons.privacy_tip,
      () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              // padding: EdgeInsets.only(
              //   // left: 10,
              // ),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Text(
                    "About Us",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        letterSpacing: 0.1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (list[index].name == 'About') {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => update_profile(),
                          //   ),
                          // );
                        } else if (list[index].name == 'Terms of Use') {
                          // setIt();
                        } else if (list[index].name == 'Privacy policy') {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HelpSupport(),
                          //   ),
                          // );
                        }
                      },
                      child: Card(
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  list[index].image,
                                  color: Colors.grey.shade400,
                                  size: 30,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        list[index].name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        list[index].desc,
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Text(
            //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
            //   "\n\n It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
            //   textAlign: TextAlign.left,
            //   style: Theme.of(context).textTheme.caption!.copyWith(
            //       letterSpacing: 0.1,
            //       fontSize: 18,
            //       // fontWeight: FontWeight.bold,
            //       color: Theme.of(context).textTheme.bodyText1!.color),
            // ),
          ],
        ),
      ),
    );
  }
}
