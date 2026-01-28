import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/features/home/data/disciplines_data.dart';
import 'package:uniordle/shared/exports/home_exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onDisciplineTap(BuildContext context, Discipline sub) {
    Navigator.of(context).pushNamed('/setup', arguments: sub);
  }

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppLayout.sidePadding),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const HomeHero(),
          const SizedBox(height: 36),
          DisciplineGrid(
            disciplines: DisciplinesData.all,
            onSubjectTap: (sub) => _onDisciplineTap(context, sub),
          ),
        ],
      ),
    ),
  );
}
}