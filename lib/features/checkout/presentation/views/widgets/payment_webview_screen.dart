import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;
  final Function(bool success) onPaymentFinished;

  const PaymentWebViewScreen({
    super.key,
    required this.paymentUrl,
    required this.onPaymentFinished,
  });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
            // Check for success in URL (standard Paymob redirect params)
            if (url.contains('success=true')) {
              widget.onPaymentFinished(true);
            } else if (url.contains('success=false')) {
              widget.onPaymentFinished(false);
            }
          },
          onWebResourceError: (error) {
            debugPrint('WebResourceError: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BasicText(
          color: Colors.black,
          text: 'Payment',
          fontSize: 18.sp,
          isBold: true,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: Color(0xFF2D4373)),
            ),
        ],
      ),
    );
  }
}
