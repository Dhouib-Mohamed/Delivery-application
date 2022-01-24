import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String? name;
  final Color? c;
  final String role;
  const LoginButton(
      {Key? key, required this.name, required this.c, required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(right: 32, top: 10, left: 32, bottom: 13),
        child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(c!),
                fixedSize: MaterialStateProperty.all(const Size(330, 48))),
            onPressed: () {
              Navigator.pushNamed(context, role);
            },
            child: Text(
              name!,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )));
  }
}

class LoginButtonNormal extends StatelessWidget {
  final String? name;
  final String role;
  const LoginButtonNormal({Key? key, required this.name, required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, top: 6, left: 32, bottom: 13),
      child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              fixedSize: MaterialStateProperty.all(const Size(330, 48)),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  side: BorderSide(
                color: Color(0xff8E8E93),
                width: 10,
              )))),
          onPressed: () {
            Navigator.pushNamed(context, role);
          },
          child: Text(
            name!,
            style: const TextStyle(color: Color(0xff8E8E93), fontSize: 17),
          )),
    );
  }
}

class LoginButtonColored extends StatelessWidget {
  final icon;
  final String? name;
  final Color? c;
  final String role;
  const LoginButtonColored(
      {Key? key,
      required this.name,
      required this.icon,
      required this.c,
      required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, top: 6, left: 32, bottom: 13),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(c!),
              fixedSize: MaterialStateProperty.all(const Size(330, 48))),
          onPressed: () {
            Navigator.pushNamed(context, role);
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ImageIcon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            Text(
              name!,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )
          ])),
    );
  }
}

class Input extends StatelessWidget {
  final String field;
  const Input({
    Key? key,
    required this.field,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, top: 6, left: 32, bottom: 18),
      child: TextFormField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(), labelText: field),
      ),
    );
  }
}

class TappedText extends StatelessWidget {
  final String text;
  final Color? c;
  final String tapped;
  final String role;
  const TappedText(
      {Key? key,
      this.c,
      required this.text,
      required this.tapped,
      required this.role})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 35, bottom: 20),
      child: SizedBox(
        width: 328,
        height: 24,
        child: Row(children: [
          Text(
            text,
            style: const TextStyle(
              fontFamily: "Inter",
              fontSize: 13,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, role);
            },
            child: Text(
              tapped,
              style: TextStyle(
                fontFamily: "Inter",
                color: (c == null) ? const Color(0xffbd2005) : c,
                fontSize: 13,
              ),
            ),
          )
        ]),
      ),
    );
  }
}