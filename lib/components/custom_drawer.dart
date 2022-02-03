import 'package:flutter/material.dart';
import 'package:task/blocs/login_bloc.dart';
import 'package:task/components/custom_buttom_nota.dart';
import 'package:task/screens/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final colortext = const Color.fromRGBO(92, 157, 254, 1);
  final _blocController = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.cloud_done_outlined,
                      color: Color.fromRGBO(92, 157, 254, 1),
                    )),
                IconButton(
                    iconSize: 32,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.dark_mode,
                      color: Color.fromRGBO(92, 157, 254, 1),
                    )),
              ],
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                "https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574?b=1&k=20&m=1300972574&s=170667a&w=0&h=2nBGC7tr0kWIU8zRQ3dMg-C5JLo9H2sNUuDjQ5mlYfo="),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Carlos Silveira",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colortext,
            ),
            textAlign: TextAlign.center,
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.checklist_rounded,
                color: Color.fromRGBO(92, 157, 254, 1),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "AGENDA",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(92, 157, 254, 1),
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView(
            children: [CustomButtomNota()],
          )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[50],
            ),
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: colortext,
            ),
          ),
          Container(
            color: Colors.blue.shade100,
            height: 70,
            child: InkWell(
              onTap: () {
                _blocController.logout();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.logout,
                    color: Color.fromRGBO(92, 157, 254, 1),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "SAIR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(92, 157, 254, 1),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
