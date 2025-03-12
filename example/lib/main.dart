import 'package:ff_drop_down_list/ff_drop_down_list.dart';
import 'package:ff_drop_down_list/model/contextual_colors.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      title: kTitle,
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// This is list of city which will pass to the drop down
  final List<DropDownItem<String>> _listOfCities = [
    DropDownItem<String>(kTokyo),
    DropDownItem<String>(kNewYork),
    DropDownItem<String>(kLondon),
    DropDownItem<String>(kParis),
    DropDownItem<String>(kMadrid),
    DropDownItem<String>(kDubai),
    DropDownItem<String>(kRome),
    DropDownItem<String>(kBarcelona),
    DropDownItem<String>(kCologne),
    DropDownItem<String>(kMonteCarlo),
    DropDownItem<String>(kPuebla),
    DropDownItem<String>(kFlorence),
  ];

  /// This is list of language with custom model which will pass to the drop down
  final List<DropDownItem<LanguageModel>> _listOfLanguages = [
    DropDownItem(LanguageModel(name: kEnglish, code: kEn)),
    DropDownItem(LanguageModel(name: kSpanish, code: kEs)),
    DropDownItem(LanguageModel(name: kFrench, code: kFr)),
    DropDownItem(LanguageModel(name: kGerman, code: kDe)),
    DropDownItem(LanguageModel(name: kChinese, code: kZh)),
    DropDownItem(LanguageModel(name: kHindi, code: kHi)),
    DropDownItem(LanguageModel(name: kArabic, code: kAr)),
    DropDownItem(LanguageModel(name: kRussian, code: kRu)),
    DropDownItem(LanguageModel(name: kJapanese, code: kJa)),
    DropDownItem(LanguageModel(name: kPortuguese, code: kPt)),
    DropDownItem(LanguageModel(name: kItalian, code: kIt)),
    DropDownItem(LanguageModel(name: kKorean, code: kKo)),
  ];

  /// This is register text field controllers
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _cityTextEditingController =
      TextEditingController();
  final TextEditingController _languageTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _cityTextEditingController.dispose();
    _languageTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: launchExample, child: Text('Launch Example')),
              const SizedBox(height: 30.0),
              const Text(
                kRegister,
                style: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              AppTextField(
                textEditingController: _nameTextEditingController,
                title: kName,
                hint: kEnterYourName,
              ),
              AppTextField(
                textEditingController: _emailTextEditingController,
                title: kEmail,
                hint: kEnterYourEmail,
              ),
              AppTextField(
                textEditingController: _cityTextEditingController,
                title: kCity,
                hint: kChooseYourCity,
                isReadOnly: true,
                onTextFieldTap: onCityTextFieldTap,
              ),
              AppTextField(
                textEditingController: _languageTextEditingController,
                title: kLanguage,
                hint: kChooseYourLanguage,
                isReadOnly: true,
                onTextFieldTap: onLanguageTextFieldTap,
              ),
              AppTextField(
                textEditingController: _passwordTextEditingController,
                title: kPassword,
                hint: kAddYourPassword,
                isReadOnly: false,
              ),
              const SizedBox(height: 15.0),
              const AppElevatedButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Launches the basic example
  void launchExample() {
    DropDown<String>(
      data: DropDownData.future(Future.delayed(
        Duration(seconds: 2),
        () => <DropDownItem<String>>[
          DropDownItem<String>(kLondon),
          DropDownItem<String>(kRome),
          DropDownItem<String>(kParis),
          DropDownItem<String>(kTokyo),
          DropDownItem<String>(kMadrid),
          DropDownItem<String>(kNewYork),
          DropDownItem<String>(kBarcelona),
        ],
      )),
      options: DropDownOptions(
        onSingleSelected: (DropDownItem<String> selectedItem) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(selectedItem.data),
            ),
          );
        },
      ),
    ).show(context);
  }

  /// Handles the text field tap for the city
  void onCityTextFieldTap() {
    DropDown<String>(
      data: DropDownData(_listOfCities),
      options: DropDownOptions(
        enableMultipleSelection: true,
        maxSelectedItems: 3,
        isDismissible: true,
        onSelected: (selectedItems) {
          showSnackBar(selectedItems.asItemData().toString());
        },
      ),
      style: DropDownStyle.build(
        (context) => DropDownStyle(
          searchCursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
          headerWidget: const Text(
            kCities,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          submitButtonText: 'Save',
          clearButtonText: 'Clear',
          tileColor: BrightnessColor(
            light: Colors.cyan.shade100,
            dark: Colors.cyan.shade700,
          ),
          selectedTileColor: BrightnessColor(
            light: Colors.cyan.shade200,
            dark: Colors.cyan.shade800,
          ),
        ),
      ),
    ).show(context);
  }

  /// Handles the text field tap for the language
  void onLanguageTextFieldTap() {
    DropDown<LanguageModel>(
      data: DropDownData(_listOfLanguages),
      options: DropDownOptions(
        enableMultipleSelection: true,
        maxSelectedItems: 3,
        onSelected: (items) => showSnackBar(items.toString()),
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          kLanguages,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonText: 'Save',
        clearButtonText: 'Clear',
      ),
    ).show(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

/// This is Common App text field class
class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final bool isReadOnly;
  final VoidCallback? onTextFieldTap;

  const AppTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    this.isReadOnly = false,
    this.onTextFieldTap,
    super.key,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(height: 5.0),
        TextFormField(
          controller: widget.textEditingController,
          cursorColor: Colors.black,
          readOnly: widget.isReadOnly,
          onTap: widget.isReadOnly
              ? () {
                  FocusScope.of(context).unfocus();
                  widget.onTextFieldTap?.call();
                }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding: const EdgeInsets.only(
              left: 8,
              bottom: 0,
              top: 0,
              right: 15,
            ),
            hintText: widget.hint,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}

/// This is common class for 'REGISTER' elevated button
class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(70, 76, 222, 1),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child: const Text(
          kREGISTER,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// This is custom model class which we will use in drop down
class LanguageModel implements DropDownItemBuilder, DropDownItemSearchable {
  final String name;
  final String code;

  LanguageModel({
    required this.name,
    required this.code,
  });

  @override
  String toString() => "Language(name: $name, code: $code)";

  @override
  Widget build(BuildContext context, int index) => RichText(
        text: TextSpan(
          text: name,
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: ' $code',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
            ),
          ],
        ),
      );

  @override
  bool satisfiesSearch(String query) =>
      name.toLowerCase().contains(query.toLowerCase()) ||
      code.toLowerCase().contains(query.toLowerCase());
}
