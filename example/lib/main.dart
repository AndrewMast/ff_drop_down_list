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
  final List<SelectedListItem<String>> _listOfCities = [
    SelectedListItem<String>(data: kTokyo),
    SelectedListItem<String>(data: kNewYork),
    SelectedListItem<String>(data: kLondon),
    SelectedListItem<String>(data: kParis),
    SelectedListItem<String>(data: kMadrid),
    SelectedListItem<String>(data: kDubai),
    SelectedListItem<String>(data: kRome),
    SelectedListItem<String>(data: kBarcelona),
    SelectedListItem<String>(data: kCologne),
    SelectedListItem<String>(data: kMonteCarlo),
    SelectedListItem<String>(data: kPuebla),
    SelectedListItem<String>(data: kFlorence),
  ];

  /// This is list of language with custom model which will pass to the drop down
  final List<SelectedListItem<LanguageModel>> _listOfLanguages = [
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kEnglish, code: kEn),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kSpanish, code: kEs),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kFrench, code: kFr),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kGerman, code: kDe),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kChinese, code: kZh),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kHindi, code: kHi),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kArabic, code: kAr),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kRussian, code: kRu),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kJapanese, code: kJa),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kPortuguese, code: kPt),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kItalian, code: kIt),
    ),
    SelectedListItem<LanguageModel>(
      data: LanguageModel(name: kKorean, code: kKo),
    ),
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
      data: <SelectedListItem<String>>[
        SelectedListItem<String>(data: 'Tokyo'),
        SelectedListItem<String>(data: 'New York'),
        SelectedListItem<String>(data: 'London'),
      ],
      options: DropDownOptions(
        onSingleSelected: (SelectedListItem<String> selectedItem) {
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
      data: _listOfCities,
      options: DropDownOptions(
        enableMultipleSelection: true,
        maxSelectedItems: 3,
        isDismissible: true,
        onSelected: (selectedItems) {
          List<String> list = [];
          for (var item in selectedItems) {
            list.add(item.data);
          }
          showSnackBar(list.toString());
        },
      ),
      styleBuilder: (context) => DropDownStyle(
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
            light: Colors.cyan.shade100, dark: Colors.cyan.shade700),
        selectedTileColor: BrightnessColor(
            light: Colors.cyan.shade200, dark: Colors.cyan.shade800),
      ),
    ).show(context);
  }

  /// Handles the text field tap for the language
  void onLanguageTextFieldTap() {
    DropDown<LanguageModel>(
      data: _listOfLanguages,
      options: DropDownOptions<LanguageModel>(
        enableMultipleSelection: true,
        maxSelectedItems: 3,
        isDismissible: true,
        listItemBuilder: (int index, SelectedListItem<LanguageModel> dataItem) {
          return Text(
            '${dataItem.data.name} : ${dataItem.data.code}',
          );
        },
        onSelected: (selectedItems) {
          List<String> list = [];
          for (var item in selectedItems) {
            list.add('${item.data.name} : ${item.data.code}');
          }
          showSnackBar(list.toString());
        },
        searchDelegate:
            (String query, List<SelectedListItem<LanguageModel>> dataItems) {
          return dataItems
              .where((item) =>
                  item.data.name.toLowerCase().contains(query.toLowerCase()) ||
                  item.data.code.toLowerCase().contains(query.toLowerCase()))
              .toList();
        },
      ),
      style: DropDownStyle(
        listSeparatorColor: BrightnessColor(
          light: Colors.black12,
          dark: Colors.white12,
        ),
        tileColor: ThemedColor((theme) => theme.primaryColor),
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
class LanguageModel {
  final String name;
  final String code;

  LanguageModel({
    required this.name,
    required this.code,
  });
}
