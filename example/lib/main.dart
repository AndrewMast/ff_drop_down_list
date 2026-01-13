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
                  onPressed: launchFutureExample,
                  child: Text('Launch Future Example')),
              const SizedBox(height: 8),
              TextButton(
                  onPressed: launchEmptySearchExample,
                  child: Text('Launch Empty Search Examples')),
              const SizedBox(height: 8),
              TextButton(
                  onPressed: launchProductSearchExample,
                  child: Text('Launch Product Search Example')),
              const SizedBox(height: 8),
              TextButton(
                  onPressed: launchUserSearchExample,
                  child: Text('Launch User Search Example')),
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

  /// Launches the future example
  void launchFutureExample() {
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

  /// Launches empty search results examples
  void launchEmptySearchExample() {
    DropDown<String>(
      data: DropDownData(_listOfCities),
      options: DropDownOptions(
        onSingleSelected: (DropDownItem<String> selectedItem) {
          showSnackBar('Selected: ${selectedItem.data}');
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Empty Search Examples',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        emptySearchResultsWidgetBuilder: (String searchQuery, int count) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off,
                size: 48,
                color: Colors.grey[600],
              ),
              const SizedBox(height: 16),
              Text(
                'No results for "$searchQuery"',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try searching from $count available cities.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          );
        },
      ),
    ).show(context);
  }

  /// Launches product search example with realistic empty states
  void launchProductSearchExample() {
    final products = [
      ProductItem(name: 'iPhone 15 Pro', category: 'Electronics', price: 999),
      ProductItem(
          name: 'Samsung Galaxy S24', category: 'Electronics', price: 899),
      ProductItem(name: 'MacBook Pro M3', category: 'Electronics', price: 1999),
      ProductItem(name: 'iPad Air', category: 'Electronics', price: 599),
      ProductItem(name: 'AirPods Pro', category: 'Electronics', price: 249),
      ProductItem(name: 'Sony WH-1000XM5', category: 'Electronics', price: 399),
      ProductItem(name: 'Nike Air Max', category: 'Footwear', price: 150),
      ProductItem(name: 'Adidas Ultraboost', category: 'Footwear', price: 180),
      ProductItem(name: 'Levi\'s 501 Jeans', category: 'Clothing', price: 89),
      ProductItem(
          name: 'Ray-Ban Aviators', category: 'Accessories', price: 199),
    ];

    DropDown<ProductItem>(
      data: DropDownData(products.map((p) => DropDownItem(p)).toList()),
      options: DropDownOptions(
        onSingleSelected: (DropDownItem<ProductItem> selectedItem) {
          showSnackBar(
              'Selected: ${selectedItem.data.name} - \$${selectedItem.data.price}');
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Product Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        searchHintText: 'Search products by name or category...',
        emptySearchResultsTextBuilder: (String searchQuery, int count) {
          final lowerQuery = searchQuery.toLowerCase();

          if (lowerQuery.contains('phone') || lowerQuery.contains('mobile')) {
            return 'No phones found. Try "iPhone", "Samsung", or "Galaxy"';
          } else if (lowerQuery.contains('shoe') ||
              lowerQuery.contains('sneaker')) {
            return 'No shoes found. Try "Nike", "Adidas", or check "Footwear" category';
          } else if (searchQuery.length < 2) {
            return 'Keep typing to search $count products...';
          } else if (lowerQuery.contains('cheap') ||
              lowerQuery.contains('budget')) {
            return 'No budget items found. Lowest price is \$89 for Levi\'s jeans';
          }

          return 'No products match "$searchQuery" in our catalog of $count items';
        },
      ),
    ).show(context);
  }

  /// Launches user search example with advanced empty states
  void launchUserSearchExample() {
    final users = [
      UserItem(
          name: 'John Smith',
          email: 'john.smith@company.com',
          department: 'Engineering',
          status: 'Active'),
      UserItem(
          name: 'Sarah Johnson',
          email: 'sarah.j@company.com',
          department: 'Marketing',
          status: 'Active'),
      UserItem(
          name: 'Mike Chen',
          email: 'mike.chen@company.com',
          department: 'Engineering',
          status: 'Away'),
      UserItem(
          name: 'Emily Davis',
          email: 'emily.davis@company.com',
          department: 'Sales',
          status: 'Active'),
      UserItem(
          name: 'Robert Wilson',
          email: 'r.wilson@company.com',
          department: 'HR',
          status: 'Active'),
      UserItem(
          name: 'Lisa Anderson',
          email: 'lisa.a@company.com',
          department: 'Design',
          status: 'Offline'),
      UserItem(
          name: 'David Martinez',
          email: 'david.m@company.com',
          department: 'Engineering',
          status: 'Active'),
      UserItem(
          name: 'Jennifer Taylor',
          email: 'j.taylor@company.com',
          department: 'Finance',
          status: 'Active'),
    ];

    DropDown<UserItem>(
      data: DropDownData(users.map((u) => DropDownItem(u)).toList()),
      options: DropDownOptions(
        enableMultipleSelection: true,
        onSelected: (selectedUsers) {
          final names = selectedUsers.map((u) => u.data.name).join(', ');
          showSnackBar('Selected: $names');
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'User Directory',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        searchHintText: 'Search by name, email, or department...',
        emptySearchResultsWidgetBuilder: (String searchQuery, int count) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.person_search,
                    size: 30,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'No users found',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'No results for "$searchQuery" in all $count users',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '💡 Search Tips:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '• Search by full name or email\n• Try department names (Engineering, Marketing)\n• Use partial names (e.g., "Jo" for John)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
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

/// Product model for product search example
class ProductItem implements DropDownItemBuilder, DropDownItemSearchable {
  final String name;
  final String category;
  final double price;

  ProductItem({
    required this.name,
    required this.category,
    required this.price,
  });

  @override
  String toString() =>
      "Product(name: $name, category: $category, price: \$${price.toStringAsFixed(2)})";

  @override
  Widget build(BuildContext context, int index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ],
        ),
      );

  @override
  bool satisfiesSearch(String query) {
    final lowerQuery = query.toLowerCase();
    return name.toLowerCase().contains(lowerQuery) ||
        category.toLowerCase().contains(lowerQuery) ||
        price.toString().contains(query);
  }
}

/// User model for user search example
class UserItem implements DropDownItemBuilder, DropDownItemSearchable {
  final String name;
  final String email;
  final String department;
  final String status;

  UserItem({
    required this.name,
    required this.email,
    required this.department,
    required this.status,
  });

  @override
  String toString() =>
      "User(name: $name, email: $email, department: $department, status: $status)";

  @override
  Widget build(BuildContext context, int index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: _getStatusColor(),
              child: Text(
                name
                    .split(' ')
                    .map((part) => part[0])
                    .take(2)
                    .join()
                    .toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  department,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 10,
                      color: _getStatusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'away':
        return Colors.orange;
      case 'offline':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  @override
  bool satisfiesSearch(String query) {
    final lowerQuery = query.toLowerCase();
    return name.toLowerCase().contains(lowerQuery) ||
        email.toLowerCase().contains(lowerQuery) ||
        department.toLowerCase().contains(lowerQuery) ||
        status.toLowerCase().contains(lowerQuery);
  }
}
