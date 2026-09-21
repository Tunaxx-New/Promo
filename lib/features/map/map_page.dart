import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:promo/core/api/api.dart';
import 'package:promo/features/map/map_service.dart';
import 'package:promo/features/map/widgets/error_card.dart';
import 'package:promo/features/map/widgets/point_summary.dart';
import 'package:promo/features/map/widgets/points_counter.dart';
import 'package:promo/shared/extensions/localization_extension.dart';
import 'package:promo/shared/models/map_point.dart';
import 'package:promo/shared/theme/app_colors.dart';
import 'package:promo/shared/theme/app_strings.dart';
import 'package:promo/shared/widgets/api_form/http_method.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  final PublicMapService _service = PublicMapService();

  List<MapPoint> _points = [];

  MapPoint? _selectedPoint;

  bool _loading = true;
  String? _error;
  bool _mapReady = false;

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  Future<void> _loadPoints() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final points = await _service.getPoints();

      if (!mounted) return;

      setState(() {
        _points = points;
        _loading = false;
      });

      if (points.isNotEmpty) {
        _moveToPoints(points);
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _moveToPoints(List<MapPoint> points) async {
    if (!_mapReady || points.isEmpty) return;

    if (points.length == 1) {
      _mapController.move(
        LatLng(points.first.latitude, points.first.longitude),
        14,
      );
      return;
    }

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: LatLngBounds(LatLng(minLat, minLng), LatLng(maxLat, maxLng)),
        padding: const EdgeInsets.all(80),
      ),
    );
  }

  Widget buildView(context, colorScheme) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return ErrorCard(error: _error!, onRetry: _loadPoints);

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: LatLng(0, 0),
            initialZoom: 13,
            onTap: (_, __) {
              setState(() {
                _selectedPoint = null;
              });
            },
            onMapReady: () {
              _mapReady = true;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted || _points.isEmpty) return;

                _moveToPoints(_points);
              });
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'kz.nikita.lider',
            ),

            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap ${context.l10n.contributors}',
                  onTap: () => launchUrl(
                    Uri.parse('https://www.openstreetmap.org/copyright'),
                  ),
                ),
                TextSourceAttribution(AppStrings.companyName),
              ],
            ),

            MarkerLayer(
              markers: _points.map((point) {
                final selected = _selectedPoint?.id == point.id;

                return Marker(
                  point: LatLng(point.latitude, point.longitude),
                  width: selected ? 64 : 56,
                  height: selected ? 64 : 56,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPoint = point;
                      });

                      _mapController.move(
                        LatLng(point.latitude, point.longitude),
                        15,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: selected ? 58 : 50,
                      height: selected ? 58 : 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.surface,
                        border: Border.all(
                          color: colorScheme.primary,
                          width: selected ? 4 : 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(6),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),

        if (_selectedPoint != null)
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: PointSummary(
              point: _selectedPoint!,
              onClose: () {
                setState(() {
                  _selectedPoint = null;
                });
              },
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: buildView(context, colorScheme),
    );
  }
}
