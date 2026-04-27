import '../models/order_model.dart';
import '../models/address_model.dart';

class CheckoutRemoteDataSource {
  /// Mock fetching saved addresses
  Future<List<AddressModel>> fetchSavedAddresses() async {
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Simulate network latency
    return [
      AddressModel(
        id: 'addr1',
        firstName: 'Muhamed',
        lastName: 'Hassan',
        phoneNumber: '+20 123 456 7890',
        streetAddress: '15 El Tahrir St.',
        city: 'Cairo',
        areaDistrict: 'Zamalek',
      ),
    ];
  }

  /// Mock placing an order
  Future<String> submitOrder(OrderModel order) async {
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Simulate API processing time

    // Simulate error scenario randomly? No, let's keep it reliable for now.
    // Return a mocked Order ID
    return 'EGY-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
  }
}
