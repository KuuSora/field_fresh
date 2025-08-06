# Shop Dashboard Application

This is a Flutter application designed to serve as a shop dashboard. It provides an interface for managing products, viewing orders, and editing user profiles.

## Project Structure

The project is organized into the following directories and files:

```
shop_dashboard_app
├── lib
│   ├── main.dart                     # Entry point of the application
│   ├── screens                       # Contains all screen widgets
│   │   ├── dashboard_screen.dart     # Dashboard screen with key metrics
│   │   ├── products_screen.dart      # Screen to manage products
│   │   ├── orders_screen.dart        # Screen to view customer orders
│   │   └── profile_screen.dart       # Screen to view and edit user profile
│   ├── widgets                       # Contains reusable widgets
│   │   ├── product_card.dart         # Widget to display product information
│   │   ├── order_card.dart           # Widget to display order information
│   │   └── dashboard_header.dart     # Widget for the dashboard header
│   ├── models                        # Contains data models
│   │   ├── product.dart              # Model for product data
│   │   └── order.dart                # Model for order data
│   └── utils                         # Utility functions and constants
│       └── constants.dart            # Constant values used in the app
├── pubspec.yaml                      # Flutter project configuration file
└── README.md                         # Documentation for the project
```

## Getting Started

To run this application, ensure you have Flutter installed on your machine. Follow these steps:

1. Clone the repository:
   ```
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```
   cd shop_dashboard_app
   ```

3. Install the dependencies:
   ```
   flutter pub get
   ```

4. Run the application:
   ```
   flutter run
   ```

## Features

- **Dashboard Screen**: View key metrics and navigate to other sections of the app.
- **Products Management**: Add, edit, and view products in the shop.
- **Orders Management**: View customer orders and their statuses.
- **User Profile**: Edit and manage user profile information.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
t91i7L45J59XLwJG
 mongodb://atlas-sql-6892e1a8cb7bdd613102fbdc-vugfx5.a.query.mongodb.net/sample_mflix?ssl=true&authSource=admin