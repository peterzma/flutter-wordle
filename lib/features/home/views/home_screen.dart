import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/features/home/data/disciplines_data.dart';
import 'package:uniordle/shared/exports/home_screen_exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeTab = 'home';

  final List<Discipline> _disciplines = DisciplinesData.all;

  void _onDisciplineTap(Discipline sub) {
    Navigator.of(context).pushNamed(
      '/setup',
      arguments: sub, 
    );
  }

  void _onTabChange(String tabId) => setState(() => _activeTab = tabId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: HomeHeader(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.kSidePadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HeroSection(),
              const SizedBox(height: 36),
              DisciplineGrid(
                disciplines: _disciplines,
                onSubjectTap: _onDisciplineTap,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeFooter(
        activeTab: _activeTab, 
        onTabChange: _onTabChange,
      ),
    );
  }
}