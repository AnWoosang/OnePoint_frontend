import 'package:flutter/material.dart';
import '../../constants/region_map.dart';

class RegionSelectorDialog extends StatefulWidget {
  final String? initialRegion;
  const RegionSelectorDialog({super.key, this.initialRegion});

  @override
  State<RegionSelectorDialog> createState() => _RegionSelectorDialogState();
}

class _RegionSelectorDialogState extends State<RegionSelectorDialog> {
  String? _selectedProvince;
  String? _selectedDistrict;

  @override
  void initState() {
    super.initState();
    if (widget.initialRegion != null) {
      // Try to infer province from initial region
      regionMap.forEach((prov, districts) {
        if (districts.contains(widget.initialRegion)) {
          _selectedProvince = prov;
          _selectedDistrict = widget.initialRegion;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provinces = regionMap.keys.toList();
    final districts = _selectedProvince != null ? regionMap[_selectedProvince!]! : <String>[];

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Container(
        width: 420,
        height: 520,
        color: Colors.grey.shade50,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '지역 선택',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Row(
                children: [
                  // Province list
                  Expanded(
                    child: ListView.builder(
                      itemCount: provinces.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _buildProvinceTile(null, '전국');
                        }
                        final province = provinces[index - 1];
                        return _buildProvinceTile(province, province);
                      },
                    ),
                  ),
                  VerticalDivider(width: 1),
                  // District list
                  Expanded(
                    child: _selectedProvince == null
                        ? const Center(
                            child: Text(
                              '시/도를 먼저 선택하세요',
                              style: TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: districts.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return _buildDistrictTile(null, '${_selectedProvince!} 전체');
                              }
                              final district = districts[index - 1];
                              return _buildDistrictTile(district, district);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProvinceTile(String? provinceValue, String display) {
    final isSelected = provinceValue == _selectedProvince;
    return ListTile(
      dense: true,
      title: Text(display),
      selected: isSelected,
      selectedColor: Theme.of(context).colorScheme.primary,
      selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
      trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary, size: 18) : null,
      onTap: () {
        setState(() {
          _selectedProvince = provinceValue;
          _selectedDistrict = null;
        });
        if (provinceValue == null) {
          // 전국 선택
          Navigator.pop(context, null);
        }
      },
    );
  }

  Widget _buildDistrictTile(String? districtValue, String display) {
    final isSelected = districtValue == _selectedDistrict;
    return ListTile(
      dense: true,
      title: Text(display),
      selected: isSelected,
      selectedColor: Theme.of(context).colorScheme.primary,
      selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
      trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary, size: 18) : null,
      onTap: () {
        final result = districtValue == null
            ? (_selectedProvince != null ? '$_selectedProvince 전체' : null)
            : '$_selectedProvince $districtValue';
        Navigator.pop(context, result);
      },
    );
  }
} 