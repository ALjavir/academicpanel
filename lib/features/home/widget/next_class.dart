import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:flutter/material.dart';

class NextClass extends StatefulWidget {
  final TodayClass todayClass;
  const NextClass({super.key, required this.todayClass});

  @override
  State<NextClass> createState() => _NextClassState();
}

class _NextClassState extends State<NextClass> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IntrinsicHeight(
            // <--- 1. CRITICAL: Makes the divider stretch to full height
            child: Row(
              children: [
                // ================== LEFT SIDE (Main Class) ==================
                Expanded(
                  flex: 3, // Takes 60% of width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 1. Course Name
                      Text(
                        widget.todayClass.classTime![0].name,
                        // "Data Science(CSE-322)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorStyle.Textblue, // Your branding color
                        ),
                      ),
                      const SizedBox(height: 8),

                      // 2. Time
                      Text(
                        widget.todayClass.classTime![0].time.toString(),
                        // "10:30 AM - 12:00 PM",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorStyle.Textblue,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 3. Location & Professor Row
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.red[900],
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.todayClass.classTime![0].room,
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorStyle.Textblue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 16), // Gap between items
                          Icon(
                            Icons.person_outline,
                            color: Colors.red[900],
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.todayClass.classTime![0].instracter,
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorStyle.Textblue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ================== THE DIVIDER LINE ==================
                Container(
                  width: 2, // Thickness of the grey line
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),

                // ================== RIGHT SIDE (List) ==================
                Expanded(
                  flex: 2, // Takes 40% of width
                  child: ListView.builder(
                    shrinkWrap:
                        true, // <--- 2. CRITICAL: Prevents "unbounded height" error
                    physics:
                        const NeverScrollableScrollPhysics(), // Disables scrolling inside the card
                    itemCount: 4, // Skip the first one (0)
                    itemBuilder: (context, index) {
                      // We adjust index because we are skipping the first item (0)
                      final realIndex = index + 1;
                      // final data = widget.classTme[realIndex];

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12.0,
                        ), // Gap between list items
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 3. THE DOT (Overlay Trick)
                            // We shift the dot to the left so it sits ON the divider line
                            Transform.translate(
                              offset: const Offset(
                                -14,
                                4,
                              ), // Move Left (-X), Move Down (+Y)
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.red[900], // Your Dot Color
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ), // White border makes it pop
                                ),
                              ),
                            ),

                            // 4. List Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // data.title
                                    "Machine Learning(CSE-350)",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: ColorStyle.Textblue.withOpacity(
                                        0.8,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    // data.time
                                    "12:10 AM - 1:00 PM",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
