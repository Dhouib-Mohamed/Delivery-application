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
                fixedSize: MaterialStateProperty.all(const Size(330, 48)),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ))),
            onPressed: () {
              Navigator.pushNamed(context, role);
            },
            child: Text(
              name!,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )));
  }
}

class ProfileButton extends StatelessWidget {
  final String? name;
  final String role;
  final IconData? icon;
  const ProfileButton(
      {Key? key, required this.name, required this.role, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, top: 6, left: 32, bottom: 13),
      child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              fixedSize: MaterialStateProperty.all(const Size(250, 48)),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ))),
          onPressed: () {
            Navigator.pushNamed(context, role);
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                icon,
                color: Colors.black,
                size: 30,
              ),
            ),
            Text(
              name!,
              style: const TextStyle(color: Colors.black, fontSize: 17),
            )
          ])),
    );
  }
}

class LoginButtonColored extends StatelessWidget {
  final ImageProvider<Object>? icon;
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
              fixedSize: MaterialStateProperty.all(const Size(330, 48)),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ))),
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

class AuthLoginButtonColored extends StatelessWidget {
  final ImageProvider<Object>? icon;
  final String? name;
  final Color? c;
  final void Function()? role;
  const AuthLoginButtonColored(
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
              fixedSize: MaterialStateProperty.all(const Size(330, 48)),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ))),
          onPressed: () {
            if (role != null) role!();
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

class AuthLoginButton extends StatelessWidget {
  final String? name;
  final Color? c;
  final void Function()? role;
  const AuthLoginButton(
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
                fixedSize: MaterialStateProperty.all(const Size(330, 48)),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ))),
            onPressed: () {
              if (role != null) role!();
            },
            child: Text(
              name!,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )));
  }
}

class Input extends StatelessWidget {
  final String field;
  final TextEditingController? control;
  final String? Function(String?)? valid;
  const Input({
    Key? key,
    required this.field,
    this.control,
    this.valid,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, top: 6, left: 32, bottom: 18),
      child: TextFormField(
        controller: control,
        keyboardType: field == 'Name'
            ? TextInputType.name
            : field == 'Email'
                ? TextInputType.emailAddress
                : field == 'Password'
                    ? TextInputType.visiblePassword
                    : field == 'Phone Number'
                        ? TextInputType.phone
                        : TextInputType.text,
        obscureText: field == 'Password',
        strutStyle: const StrutStyle(forceStrutHeight: true, height: 1),
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gapPadding: 4.0,
            ),
            labelText: field),
        validator: valid,
        onSaved: (value) {
          control?.text = value!;
        },
      ),
    );
  }
}

class FeedInput extends StatelessWidget {
  final String field;
  final TextEditingController? control;
  final String? Function(String?)? valid;
  const FeedInput({
    Key? key,
    required this.field,
    this.control,
    this.valid,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 28, left: 16, bottom: 18),
      child: TextFormField(
        controller: control,
        autofocus: true,
        strutStyle: const StrutStyle(forceStrutHeight: true, height: 1),
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gapPadding: 4.0,
            ),
            labelText: field),
        validator: valid,
        onSaved: (value) {
          control?.text = value!;
        },
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
      child: Row(children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 13,
            color: Colors.black,
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
    );
  }
}

class TappedPosition extends StatelessWidget {
  final String text;
  final Color? c;
  final String tapped;
  final String role;
  const TappedPosition(
      {Key? key,
      this.c,
      required this.text,
      required this.tapped,
      required this.role})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 25, bottom: 15),
      child: SizedBox(
        width: 328,
        height: 24,
        child: Row(children: [
          Text(
            text,
            style: const TextStyle(
              fontFamily: "Inter",
              fontSize: 13,
              color: Colors.black,
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
                fontSize: 17,
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class TappedBox extends StatefulWidget {
  final String text;
  bool val = true;
  TappedBox({Key? key, required this.text}) : super(key: key);

  @override
  State<TappedBox> createState() => _TappedBoxState();
}

class _TappedBoxState extends State<TappedBox> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 0, bottom: 15, right: 0),
      child: Row(
        children: [
          Checkbox(
            activeColor: const Color(0xffbd2005),
            onChanged: (bool? value) {
              setState(() {
                widget.val = value!;
              });
            },
            value: widget.val,
          ),
          Text(
            widget.text,
            style: const TextStyle(color: Color(0xffbd2005)),
          ),
        ],
      ),
    );
  }
}

class SimplButton extends StatelessWidget {
  final void Function()? buttonRole;

  final String buttonText;

  const SimplButton(
      {Key? key, required this.buttonRole, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            fixedSize: MaterialStateProperty.all(const Size(141, 40)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ))),
        onPressed: () {
          if (buttonRole != null) buttonRole!();
        },
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ));
  }
}
