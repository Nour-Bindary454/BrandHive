import 'package:brand/features/admin_dashboard/data/models/admin_models.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/brand_request_header.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/section_header.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/info_card.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/info_row.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/tappable_row.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/url_launcher_helper.dart';
import 'package:brand/features/admin_dashboard/presentation/views/widgets/rejection_dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandRequestDetailsScreen extends StatefulWidget {
  final AdminBrandRequest request;
  final void Function(BrandStatus, String?)? onStatusChange;

  const BrandRequestDetailsScreen({super.key, required this.request, this.onStatusChange});

  @override
  State<BrandRequestDetailsScreen> createState() => _BrandRequestDetailsScreenState();
}

class _BrandRequestDetailsScreenState extends State<BrandRequestDetailsScreen> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final raw = widget.request.rawData;
    final logoUrl = raw['logo'] is Map ? raw['logo']['url']?.toString() ?? '' : raw['logoUrl']?.toString() ?? '';
    final shipsInt = widget.request.shipsInternationally;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          BrandRequestHeader(logoUrl: logoUrl, name: raw['name']?.toString() ?? widget.request.name, status: widget.request.status),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _buildSection('Brand Information', Icons.store_outlined, [
                  InfoRow(icon: Icons.description_outlined, label: 'Description', value: raw['description']?.toString() ?? '—'),
                  InfoRow(icon: Icons.location_on_outlined, label: 'Country', value: raw['country']?.toString() ?? widget.request.location),
                  if (raw['city'] != null) InfoRow(icon: Icons.location_city_outlined, label: 'City', value: raw['city'].toString()),
                  InfoRow(icon: Icons.local_shipping_outlined, label: 'Ships Internationally', value: shipsInt ? 'Yes ✓' : 'No'),
                   InfoRow(icon: Icons.category_outlined, label: 'Categories', value: widget.request.category),
                ]),
                _buildSection('Contact Details', Icons.contact_phone_outlined, [
                  if (raw['phone'] != null) TappableRow(icon: Icons.phone_outlined, label: 'Phone', value: raw['phone'].toString(), onTap: () => launchURL('tel:${raw['phone']}')),
                  if (raw['whatsappLink'] != null) TappableRow(icon: Icons.chat_outlined, label: 'WhatsApp', value: raw['whatsappLink'].toString(), onTap: () => launchURL('https://wa.me/${raw['whatsappLink'].toString().replaceAll(RegExp(r'[^0-9]'), '')}')),
                  if (raw['website'] != null) TappableRow(icon: Icons.language_outlined, label: 'Website', value: raw['website'].toString(), onTap: () => launchURL(raw['website'].toString())),
                ]),
                if (raw['requestedBy'] is Map) _buildSection('Requested By', Icons.person_outline, [
                  InfoRow(icon: Icons.badge_outlined, label: 'Name', value: raw['requestedBy']['name']?.toString() ?? '—'),
                  TappableRow(icon: Icons.email_outlined, label: 'Email', value: raw['requestedBy']['email']?.toString() ?? '—', onTap: () => launchURL('mailto:${raw['requestedBy']['email']}')),
                ]),
                _buildSection('Request Details', Icons.info_outline, [
                  InfoRow(icon: Icons.tag_outlined, label: 'Request ID', value: widget.request.id),
                  InfoRow(icon: Icons.calendar_today_outlined, label: 'Date', value: widget.request.date),
                  InfoRow(icon: Icons.pending_outlined, label: 'Status', value: widget.request.status.name.toUpperCase()),
                  if (widget.request.rejectionReason != null) InfoRow(icon: Icons.error_outline, label: 'Rejection Reason', value: widget.request.rejectionReason!),
                ]),
                if (widget.request.status == BrandStatus.pending && widget.onStatusChange != null) _buildActions(),
                SizedBox(height: 40.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title, icon: icon),
          SizedBox(height: 12.h),
          InfoCard(children: children),
          SizedBox(height: 24.h),
        ],
      );

  Widget _buildActions() => Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Row(children: [
          Expanded(child: _btn("Approve", Icons.check, const Color(0xFF1E293B), Colors.white, () {
            widget.onStatusChange!(BrandStatus.approved, null);
            Navigator.pop(context);
          })),
          SizedBox(width: 16.w),
          Expanded(child: _btn("Reject", Icons.close, Colors.transparent, const Color(0xFFE11D48), () {
            RejectionDialogHelper.show(context: context, controller: _reasonController, onStatusChange: widget.onStatusChange!, onConfirm: () => Navigator.pop(context));
          }, isOutlined: true)),
        ]),
      );

  Widget _btn(String txt, IconData icon, Color bg, Color fg, VoidCallback tap, {bool isOutlined = false}) => ElevatedButton.icon(
        onPressed: tap,
        icon: Icon(icon, size: 16.sp),
        label: Text(txt),
        style: ElevatedButton.styleFrom(
          backgroundColor: bg, foregroundColor: fg, elevation: 0,
          side: isOutlined ? BorderSide(color: fg) : null,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
}
