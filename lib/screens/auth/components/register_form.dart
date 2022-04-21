import 'package:flutter/material.dart';
import 'package:projet/services/authentication.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'custom_surfix_icon.dart';


class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticationService _auth = AuthenticationService();
  String firstname = '', lastname = '', city = '', email = '', password = '', conform_password = '', errorMessage = '';

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildCityFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () async{
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                dynamic result = await _auth.registerWithEmailAndPassword(firstname, lastname, city, email, password);
                if (result != null) {
                  Navigator.pushNamed(context, '/');
                }
              }
            },
          ),
        ],
      ),
    );
  }



  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        labelStyle: TextStyle(
          color: kTextColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kTextColor, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        labelStyle: TextStyle(
          color: kTextColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kTextColor, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        labelStyle: TextStyle(
          color: kTextColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kTextColor, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }



  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstname = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: '$kFieldNullError first name');
        } else if (value.length < 2) {
          removeError(error: 'First name $kShortFieldError');
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: '$kFieldNullError first name');
          return "";
        } else if (value.length < 2) {
          addError(error:  'First name $kShortFieldError');
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        labelStyle: TextStyle(
          color: kTextColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kTextColor, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }


  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastname = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: '$kFieldNullError last name');
        } else if (value.length < 2) {
          removeError(error: 'Last name $kShortFieldError');
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: '$kFieldNullError last name');
          return "";
        } else if (value.length < 2) {
          addError(error:  'Last name $kShortFieldError');
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        labelStyle: TextStyle(
          color: kTextColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kTextColor, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }



  TextFormField buildCityFormField() {
    return TextFormField(
      onSaved: (newValue) => city = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: '$kFieldNullError city');
        } else if (value.length < 2) {
          removeError(error: 'City $kShortFieldError');
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: '$kFieldNullError city');
          return "";
        } else if (value.length < 2) {
          addError(error:  'City $kShortFieldError');
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "City",
        hintText: "Enter your city",
        labelStyle: TextStyle(
          color: kTextColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kTextColor, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }


}
