import 'package:flutter/material.dart';
import 'package:testing_app/validators/password_input_field_validator.dart';
import 'package:uniform/uniform.dart';

import 'validators/email_input_field_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FormController formController =
      FormController(validators: {const InputFieldValidator.required()});
  @override
  void initState() {
    super.initState();

    TextFieldController.create(formController, tag: 'email')
        .setValidators({const EmailInputFieldValidator()});

    TextFieldController.create(formController, tag: 'password')
        .setValidators({const PasswordInputFieldValidator()});

    FieldController.create(formController, tag: 'checkbox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: InputForm(
                controller: formController,
                child: TextInputFieldBuilder(
                  tag: 'email',
                  builder: (context, controller, textController) {
                    return TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Email Address',
                          errorText: controller.error.message,
                        ),
                        enabled: !controller.isSubmitted,
                        onChanged: controller.onChanged);
                  },
                )),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: InputForm(
                controller: formController,
                child: TextInputFieldBuilder(
                  tag: 'password',
                  builder: (context, controller, textController) {
                    return TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.abc),
                          border: const OutlineInputBorder(),
                          hintText: 'Password',
                          errorText: controller.error.message,
                        ),
                        enabled: !controller.isSubmitted,
                        onChanged: controller.onChanged);
                  },
                )),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: InputForm(
                controller: formController,
                child: InputFieldBuilder<bool>(
                  tag: 'checkbox',
                  builder: (context, controller, _) {
                    return Checkbox(
                      value: controller.value ?? false,
                      onChanged: controller.onChanged,
                    );
                  },
                )),
          ),
          ElevatedButton(
              onPressed: () {
                if (formController.validate()) {
                  print("Form Submittted");
                } else {
                  print("Not Submitted");
                }
              },
              child: const Text("Submitt"))
        ],
      ),
    );
  }
}
