import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uniordle/home/models/subject.dart';

class SubjectGrid extends StatelessWidget {
  final List<Subject> subjects;
  final void Function(Subject) onSubjectTap;

  const SubjectGrid({
    super.key,
    required this.subjects,
    required this.onSubjectTap,
  });

  @override
  Widget build (BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: subjects.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3.5,
      ),
      itemBuilder: (context, index) {
        final sub = subjects[index];
        return _AnimatedSubjectTile(subject: sub, onTap: () => onSubjectTap(sub));
      },
    );
  }
}

class _AnimatedSubjectTile extends StatefulWidget {
  final Subject subject;
  final VoidCallback onTap;

  const _AnimatedSubjectTile({
    required this.subject,
    required this.onTap,
  });

  @override
  State<_AnimatedSubjectTile> createState() => _AnimatedSubjectTileState();
}

class _AnimatedSubjectTileState extends State<_AnimatedSubjectTile> {
  double _scale = 1.0;
  bool _hovering = false;

  void _onTapDown(_) => setState(() => _scale = 0.95);
  void _onTapUp(_) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);  

  @override
  Widget build(BuildContext context) {
    final sub = widget.subject;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1F2B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hovering ? Colors.blueAccent : Colors.grey.withValues(alpha: 0.4),
                width: _hovering ? 1.5 : 0.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration( 
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIcon(sub.icon),
                    color: sub.color ?? Colors.blue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sub.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (sub.tag != null)
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle, 
                                color: sub.tag == 'DONE' ? Colors.green : Colors.blue
                              )
                            ),
                            const SizedBox(width: 4),
                            Text(
                              sub.tag!,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: sub.tag == 'DONE' ? Colors.green : Colors.blue
                              ),
                            ),
                          ],
                        ),
                        if (sub.count != null)
                          Text(
                            '${sub.count}',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  IconData _getIcon(String name) {
    switch (name) {
      case 'category':
        return LucideIcons.layoutGrid;
      default:
        return LucideIcons.bookOpen;
    }
  }