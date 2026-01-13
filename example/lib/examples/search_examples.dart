import 'package:ff_drop_down_list/ff_drop_down_list.dart';
import 'package:flutter/material.dart';

class SearchExamples {
  static void showCustomSearchDelegateExample(BuildContext context) {
    final employees = [
      Employee('John Doe', 'Engineering', 'Senior Developer', 95000),
      Employee('Jane Smith', 'Marketing', 'Marketing Manager', 85000),
      Employee('Bob Johnson', 'Engineering', 'DevOps Engineer', 90000),
      Employee('Alice Brown', 'Design', 'UI/UX Designer', 75000),
      Employee('Charlie Wilson', 'Sales', 'Sales Representative', 65000),
      Employee('Diana Miller', 'HR', 'HR Manager', 80000),
      Employee('Edward Davis', 'Finance', 'Financial Analyst', 82000),
      Employee('Fiona Garcia', 'Engineering', 'QA Engineer', 70000),
    ];

    DropDown<Employee>(
      data: DropDownData(employees.map((e) => DropDownItem(e)).toList()),
      options: DropDownOptions(
        searchDelegate: (query, items) {
          if (query.isEmpty) return items;

          final lowerQuery = query.toLowerCase();

          // Custom search logic with different ranking
          List<DropDownItem<Employee>> rankedResults = [];

          for (final item in items) {
            final employee = item.data;
            int score = 0;

            // Exact name match gets highest score
            if (employee.name.toLowerCase() == lowerQuery) {
              score = 100;
            }
            // Name starts with query
            else if (employee.name.toLowerCase().startsWith(lowerQuery)) {
              score = 80;
            }
            // Department match
            else if (employee.department.toLowerCase() == lowerQuery) {
              score = 60;
            }
            // Department starts with query
            else if (employee.department.toLowerCase().startsWith(lowerQuery)) {
              score = 40;
            }
            // Position contains query
            else if (employee.position.toLowerCase().contains(lowerQuery)) {
              score = 30;
            }
            // Name contains query
            else if (employee.name.toLowerCase().contains(lowerQuery)) {
              score = 20;
            }

            if (score > 0) {
              item.data._searchScore = score;
              rankedResults.add(item);
            }
          }

          // Sort by search score (descending)
          rankedResults.sort(
              (a, b) => b.data._searchScore.compareTo(a.data._searchScore));

          return rankedResults;
        },
        onSingleSelected: (item) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Selected: ${item.data.name} - ${item.data.position}')),
          );
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Employee Directory',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        searchHintText: 'Search by name, department, or position...',
      ),
    ).show(context);
  }

  static void showSortAfterSearchExample(BuildContext context) {
    final products = [
      Product('Laptop Pro X1', 'Electronics', 1299.99, 4.5),
      Product('Wireless Mouse', 'Electronics', 29.99, 4.2),
      Product('Office Chair', 'Furniture', 199.99, 4.7),
      Product('Coffee Maker', 'Appliances', 89.99, 4.1),
      Product('Desk Lamp', 'Furniture', 34.99, 3.9),
      Product('USB Hub', 'Electronics', 19.99, 4.3),
      Product('Notebook Set', 'Stationery', 12.99, 4.6),
      Product('Monitor Stand', 'Furniture', 49.99, 4.4),
    ];

    DropDown<Product>(
      data: DropDownData(products.map((p) => DropDownItem(p)).toList()),
      options: DropDownOptions(
        searchDelegate: (query, items) {
          if (query.isEmpty) return items;

          final lowerQuery = query.toLowerCase();
          return items.where((item) {
            final product = item.data;
            return product.name.toLowerCase().contains(lowerQuery) ||
                product.category.toLowerCase().contains(lowerQuery);
          }).toList();
        },
        sortAfterSearch: true,
        sortDelegate: (a, b) {
          // Sort by rating first, then by price
          int ratingCompare = b.data.rating.compareTo(a.data.rating);
          if (ratingCompare != 0) return ratingCompare;
          return a.data.price.compareTo(b.data.price);
        },
        onSingleSelected: (item) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Selected: ${item.data.name} - \$${item.data.price}')),
          );
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Product Catalog (Auto-sorted by rating)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        searchHintText: 'Search products (results auto-sorted)...',
      ),
    ).show(context);
  }

  static void showAdvancedSearchWithFiltersExample(BuildContext context) {
    final books = [
      Book('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 1925, 4.3),
      Book('1984', 'George Orwell', 'Dystopian', 1949, 4.6),
      Book('To Kill a Mockingbird', 'Harper Lee', 'Classic', 1960, 4.8),
      Book('Brave New World', 'Aldous Huxley', 'Dystopian', 1932, 4.2),
      Book('The Catcher in the Rye', 'J.D. Salinger', 'Classic', 1951, 3.9),
      Book('Fahrenheit 451', 'Ray Bradbury', 'Dystopian', 1953, 4.4),
      Book('Animal Farm', 'George Orwell', 'Political', 1945, 4.1),
      Book('Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 4.5),
    ];

    DropDown<Book>(
      data: DropDownData(books.map((b) => DropDownItem(b)).toList()),
      options: DropDownOptions(
        enableMultipleSelection: true,
        searchDelegate: (query, items) {
          final lowerQuery = query.toLowerCase();

          // Handle special filter keywords
          if (lowerQuery == 'classic') {
            return items.where((item) => item.data.genre == 'Classic').toList();
          } else if (lowerQuery == 'dystopian') {
            return items
                .where((item) => item.data.genre == 'Dystopian')
                .toList();
          } else if (lowerQuery.startsWith('year:')) {
            final yearStr = lowerQuery.substring(5);
            final year = int.tryParse(yearStr);
            if (year != null) {
              return items.where((item) => item.data.year == year).toList();
            }
          } else if (lowerQuery.startsWith('rating:')) {
            final ratingStr = lowerQuery.substring(7);
            final rating = double.tryParse(ratingStr);
            if (rating != null) {
              return items.where((item) => item.data.rating >= rating).toList();
            }
          }

          // Default search
          return items.where((item) {
            final book = item.data;
            return book.title.toLowerCase().contains(lowerQuery) ||
                book.author.toLowerCase().contains(lowerQuery) ||
                book.genre.toLowerCase().contains(lowerQuery) ||
                book.year.toString().contains(lowerQuery);
          }).toList();
        },
        onSelected: (selectedBooks) {
          final titles = selectedBooks.map((b) => b.data.title).join(', ');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected books: $titles')),
          );
        },
      ),
      style: DropDownStyle(
        headerWidget: const Text(
          'Library Search',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        searchHintText:
            'Try: "classic", "dystopian", "year:1949", "rating:4.5"',
        emptySearchResultsWidgetBuilder: (query, count) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.menu_book, size: 48, color: Colors.brown),
                const SizedBox(height: 16),
                Text('No books found for "$query"'),
                const SizedBox(height: 8),
                const Text('Search tips:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Text('• Try "classic" or "dystopian" for genres'),
                const Text('• Try "year:1949" for specific year'),
                const Text('• Try "rating:4.5" for highly rated books'),
              ],
            ),
          );
        },
      ),
    ).show(context);
  }
}

class Employee implements DropDownItemBuilder, DropDownItemSearchable {
  final String name;
  final String department;
  final String position;
  final double salary;
  int _searchScore = 0;

  Employee(this.name, this.department, this.position, this.salary);

  @override
  Widget build(BuildContext context, int index) {
    return ListTile(
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('$position • $department'),
      trailing: Text(
        '\$${salary.toStringAsFixed(0)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green.shade600,
        ),
      ),
    );
  }

  @override
  bool satisfiesSearch(String query) {
    final lowerQuery = query.toLowerCase();
    return name.toLowerCase().contains(lowerQuery) ||
        department.toLowerCase().contains(lowerQuery) ||
        position.toLowerCase().contains(lowerQuery);
  }
}

class Product implements DropDownItemBuilder, DropDownItemSearchable {
  final String name;
  final String category;
  final double price;
  final double rating;

  Product(this.name, this.category, this.price, this.rating);

  @override
  Widget build(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(category,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 14, color: Colors.orange),
                  Text(rating.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool satisfiesSearch(String query) {
    final lowerQuery = query.toLowerCase();
    return name.toLowerCase().contains(lowerQuery) ||
        category.toLowerCase().contains(lowerQuery);
  }
}

class Book implements DropDownItemBuilder, DropDownItemSearchable {
  final String title;
  final String author;
  final String genre;
  final int year;
  final double rating;

  Book(this.title, this.author, this.genre, this.year, this.rating);

  @override
  Widget build(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(author, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(genre,
                    style:
                        TextStyle(fontSize: 10, color: Colors.blue.shade700)),
              ),
              const SizedBox(width: 8),
              Text('$year',
                  style: TextStyle(color: Colors.grey[600], fontSize: 11)),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 12, color: Colors.orange),
                  Text(rating.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 11)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool satisfiesSearch(String query) {
    final lowerQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowerQuery) ||
        author.toLowerCase().contains(lowerQuery) ||
        genre.toLowerCase().contains(lowerQuery) ||
        year.toString().contains(query);
  }
}
