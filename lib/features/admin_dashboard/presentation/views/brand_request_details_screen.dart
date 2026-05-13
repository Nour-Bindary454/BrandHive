import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/brand_request_header.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/section_header.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/info_card.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/info_row.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/tappable_row.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/url_launcher_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandRequestDetailsScreen extends StatelessWidget {
  final AdminBrandRequest request;
  final Function(BrandStatus)? onStatusChange;

  const BrandRequestDetailsScreen({
    super.key, 
    required this.request,
    this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    final raw = request.rawData;
    
    // Extracted Fields - Added fallback keys for robustness
    String extractedLogo = '';
    if (raw['logo'] is Map && raw['logo']['url'] != null) {
      extractedLogo = raw['logo']['url'].toString();
    } else if (raw['logoUrl'] != null) {
      extractedLogo = raw['logoUrl'].toString();
    } else if (raw['image'] is Map && raw['image']['url'] != null) {
      extractedLogo = raw['image']['url'].toString();
    } else if (raw['imageUrl'] != null) {
      extractedLogo = raw['imageUrl'].toString();
    }
    final String logoUrl = extractedLogo;

    final String name = raw['name']?.toString() ?? request.name;
    final String description = raw['description']?.toString() ?? '';
    final String country = raw['country']?.toString() ?? request.location;
    final String city = raw['city']?.toString() ?? raw['address']?.toString() ?? raw['location']?.toString() ?? '';
    
    final String phone = raw['phone']?.toString() ?? 
                         raw['phoneNumber']?.toString() ?? 
                         raw['mobile']?.toString() ?? 
                         raw['contactNumber']?.toString() ?? '';
                         
    final String website = raw['website']?.toString() ?? '';
    final String whatsapp = raw['whatsappLink']?.toString() ?? raw['whatsapp']?.toString() ?? '';
    final bool shipsInternationally = raw['shipsInternationally'] as bool? ?? false;
    final List categories = raw['categories'] is List ? raw['categories'] : [];

    // Seller info Fields
    final sellerEmail = (raw['requestedBy'] is Map)
        ? raw['requestedBy']['email']?.toString() ?? ''
        : raw['sellerEmail']?.toString() ?? raw['email']?.toString() ?? '';
    final sellerName = (raw['requestedBy'] is Map)
        ? raw['requestedBy']['name']?.toString() ?? ''
        : raw['sellerName']?.toString() ?? '';
    final sellerPhone = (raw['requestedBy'] is Map)
        ? raw['requestedBy']['phone']?.toString() ?? phone : phone;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          BrandRequestHeader(logoUrl: logoUrl, name: name, status: request.status),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Brand Information', icon: Icons.store_outlined),
                  SizedBox(height: 12.h),
                  InfoCard(children: [
                    if (description.isNotEmpty)
                      InfoRow(icon: Icons.description_outlined, label: 'Description', value: description),
                    InfoRow(icon: Icons.location_on_outlined, label: 'Country', value: country.isNotEmpty ? country : '—'),
                    if (city.isNotEmpty)
                      InfoRow(icon: Icons.location_city_outlined, label: 'City', value: city),
                    InfoRow(icon: Icons.local_shipping_outlined, label: 'Ships Internationally', value: shipsInternationally ? 'Yes ✓' : 'No'),
                    if (categories.isNotEmpty)
                      InfoRow(icon: Icons.category_outlined, label: 'Categories', value: categories.join(', ')),
                  ]),
                  SizedBox(height: 24.h),

                  const SectionHeader(title: 'Contact Details', icon: Icons.contact_phone_outlined),
                  SizedBox(height: 12.h),
                  InfoCard(children: [
                    if (sellerPhone.isNotEmpty)
                      TappableRow(icon: Icons.phone_outlined, label: 'Phone', value: sellerPhone, onTap: () => launchURL('tel:$sellerPhone')),
                    if (sellerEmail.isNotEmpty)
                      TappableRow(icon: Icons.email_outlined, label: 'Email', value: sellerEmail, onTap: () => launchURL('mailto:$sellerEmail')),
                    if (whatsapp.isNotEmpty)
                      TappableRow(icon: Icons.chat_outlined, label: 'WhatsApp', value: whatsapp, onTap: () => launchURL('https://wa.me/${whatsapp.replaceAll(RegExp(r'[^0-9]'), '')}')),
                    if (website.isNotEmpty)
                      TappableRow(icon: Icons.language_outlined, label: 'Website', value: website, onTap: () => launchURL(website.startsWith('http') ? website : 'https://$website')),
                  ]),
                  SizedBox(height: 24.h),

                  if (sellerName.isNotEmpty || sellerEmail.isNotEmpty) ...[
                    const SectionHeader(title: 'Requested By', icon: Icons.person_outline),
                    SizedBox(height: 12.h),
                    InfoCard(children: [
                      if (sellerName.isNotEmpty)
                        InfoRow(icon: Icons.badge_outlined, label: 'Name', value: sellerName),
                      if (sellerEmail.isNotEmpty)
                        TappableRow(icon: Icons.email_outlined, label: 'Email', value: sellerEmail, onTap: () => launchURL('mailto:$sellerEmail')),
                    ]),
                    SizedBox(height: 24.h),
                  ],

                  const SectionHeader(title: 'Request Details', icon: Icons.info_outline),
                  SizedBox(height: 12.h),
                  InfoCard(children: [
                    InfoRow(icon: Icons.tag_outlined, label: 'Request ID', value: request.id),
                    InfoRow(icon: Icons.calendar_today_outlined, label: 'Date', value: request.date),
                    InfoRow(icon: Icons.pending_outlined, label: 'Status', value: request.status.name.toUpperCase()),
                  ]),
                  
                  if (request.status == BrandStatus.pending && onStatusChange != null) ...[
                    SizedBox(height: 32.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                               onStatusChange!(BrandStatus.approved);
                               Navigator.pop(context);
                            },
                            icon: Icon(Icons.check, size: 16.sp),
                            label: const Text("Approve"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E293B),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                              elevation: 0,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                               onStatusChange!(BrandStatus.rejected);
                               Navigator.pop(context);
                            },
                            icon: Icon(Icons.close, size: 16.sp),
                            label: const Text("Reject"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFE11D48),
                              side: const BorderSide(color: Color(0xFFE11D48)),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
