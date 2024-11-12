import 'dart:math';

// Product class to represent an item in the cart
class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

// ShoppingCart class to manage the cart
class ShoppingCart {
  final List<Product> _items = [];
  double _tax = 0.0;

  // Add a product to the cart
  void addProduct(Product product) {
    _items.add(product);
  }

  // Remove a product from the cart
  void removeProduct(Product product) {
    _items.remove(product);
  }

  // Set the tax rate
  void setTaxRate(double rate) {
    _tax = rate;
  }

  // Calculate the total cost of the cart, including tax
  double calculateTotal() {
    double total = _items.fold(0.0, (sum, product) => sum + product.price);
    return total + (total * _tax);
  }

  // Filter products by price range
  List<Product> filterByPrice(double minPrice, double maxPrice) {
    return _items.where((product) => product.price >= minPrice && product.price <= maxPrice).toList();
  }

  // Apply a discount to the cart
  double applyDiscount(double discountPercentage) {
    return calculateTotal() * (1 - discountPercentage / 100);
  }

  // Apply a recursive discount based on the number of items
  double applyRecursiveDiscount(int minItemsForDiscount, double discountPercentage) {
    if (_items.length >= minItemsForDiscount) {
      return applyRecursiveDiscount(minItemsForDiscount, discountPercentage) * (1 - discountPercentage / 100);
    } else {
      return calculateTotal();
    }
  }
}

// Example usage
void main() {
  // Create some products
  Product product1 = Product("T-Shirt", 19.99);
  Product product2 = Product("Jeans", 49.99);
  Product product3 = Product("Shoes", 59.99);

  // Create a shopping cart
  ShoppingCart cart = ShoppingCart();

  // Add products to the cart
  cart.addProduct(product1);
  cart.addProduct(product2);
  cart.addProduct(product3);

  // Set the tax rate
  cart.setTaxRate(0.08);

  // Calculate the total cost
  double total = cart.calculateTotal();
  print("Total cost (with tax): \$${total.toStringAsFixed(2)}");

  // Filter products by price range
  List<Product> filteredProducts = cart.filterByPrice(30.0, 60.0);
  print("Products between \$30 and \$60:");
  filteredProducts.forEach((product) => print("- ${product.name}: \$${product.price}"));

  // Apply a discount
  double discountedTotal = cart.applyDiscount(10);
  print("Total cost with 10% discount: \$${discountedTotal.toStringAsFixed(2)}");

  // Apply a recursive discount
  double recursiveDiscountedTotal = cart.applyRecursiveDiscount(3, 5);
  print("Total cost with 5% recursive discount for 3+ items: \$${recursiveDiscountedTotal.toStringAsFixed(2)}");
}