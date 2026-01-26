import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threeD_containerHead.dart';
import 'package:flutter/material.dart';

class ResultTopheader extends StatelessWidget {
  final ResultPageController resultPageController;
  const ResultTopheader({super.key, required this.resultPageController});

  @override
  Widget build(BuildContext context) {
    final rowCgpaModel = resultPageController.rowCgpaModelData;
    final double cgpaProgress = rowCgpaModel.current_cgpa / 4.0;
    final double improvement =
        rowCgpaModel.current_cgpa - rowCgpaModel.pervious_cgpa;
    final double remainingCredits =
        rowCgpaModel.target_credit - rowCgpaModel.credit_completed;
    return ThreedContainerhead(
      padding: EdgeInsets.fromLTRB(10, 60, 10, 30),
      imagePath: ImageStyle.resultTopBackground(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  rowCgpaModel.comment,
                  style: Fontstyle.defult(
                    18,
                    FontWeight.w600,
                    ColorStyle.light,
                  ),
                ),
              ),
              Transform.rotate(
                angle: -0.5, // Tilted arrow
                child: const Icon(Icons.send, color: Colors.white, size: 18),
              ),
            ],
          ),

          // 2. BODY
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- CGPA SECTION ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current CGPA",
                          style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${rowCgpaModel.current_cgpa}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E3A8A), // Dark Blue
                                ),
                              ),
                              const TextSpan(
                                text: " / 4.00",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.trending_up,
                              color: Color(0xFFB71C1C),
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "+${improvement.toStringAsFixed(1)}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB71C1C),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "from last sem",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red[900],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // CGPA Progress Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "previous: ${rowCgpaModel.pervious_cgpa}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1E3A8A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Current: ${rowCgpaModel.current_cgpa}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1E3A8A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: cgpaProgress, // Value between 0.0 and 1.0
                    minHeight: 10,
                    backgroundColor: Colors.red.shade100, // Max CGPA background
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFB71C1C),
                    ), // Current CGPA
                  ),
                ),

                const SizedBox(height: 24),
                const Divider(color: Colors.grey, height: 1),
                const SizedBox(height: 24),

                // --- CREDIT SECTION ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Credit",
                          style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${rowCgpaModel.credit_completed} / ${rowCgpaModel.target_credit}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "July, 2026",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        Text(
                          "Estimated last sem",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFB71C1C),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // --- CREDIT TIMELINE (Progress Bar) ---
                Row(
                  children: [
                    _buildCreditStep(
                      icon: Icons.library_books_rounded,
                      label: "Completed",
                      value: "${rowCgpaModel.credit_completed}",
                      isActive: true,
                    ),
                    _buildDottedLine(),
                    _buildCreditStep(
                      icon: Icons.book,
                      label: "Current",
                      value: "${rowCgpaModel.credit_enrolled}",
                      isActive: true,
                    ),
                    _buildDottedLine(),
                    _buildCreditStep(
                      icon: Icons.hourglass_bottom_rounded,
                      label: "Remaining",
                      value: "$remainingCredits",
                      isActive: false,
                      isLast: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Credit Steps
  Widget _buildCreditStep({
    required IconData icon,
    required String label,
    required String value,
    required bool isActive,
    bool isLast = false,
  }) {
    final color = isActive || isLast ? const Color(0xFFB71C1C) : Colors.grey;
    final textColor = const Color(0xFF1E3A8A);

    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Dotted Line
  Widget _buildDottedLine() {
    return SizedBox(
      width: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          5,
          (index) => Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A8A),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
