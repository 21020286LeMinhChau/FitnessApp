import 'package:flutter/material.dart';
import 'package:fitness/common/color_extension.dart';

class TargetCell extends StatefulWidget {
  final String icon;
  final String value;
  final String title;
  final Function(String value, String title) onSelect;

  const TargetCell({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
    required this.onSelect,
  });

  @override
  _TargetCellState createState() => _TargetCellState();
}

class _TargetCellState extends State<TargetCell> {
  bool isSelected = false;

  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });
    widget.onSelect(widget.value, widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: Stack(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? TColor.green : TColor.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Image.asset(
                  widget.icon,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: TColor.primaryG,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                        },
                        child: Text(
                          widget.value,
                          style: TextStyle(
                            color: TColor.white.withOpacity(0.7),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: Icon(
                Icons.check_circle,
                color: TColor.primaryG.first,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
