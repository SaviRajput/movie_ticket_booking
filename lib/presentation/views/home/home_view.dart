import 'package:book_my_movie/presentation/views/home/components/all_movies_component.dart';
import 'package:book_my_movie/presentation/views/home/components/now_showing_component.dart';
import 'package:book_my_movie/presentation/views/home/providers/home_provider.dart';
import 'package:book_my_movie/presentation/widgets/common_app_bar.dart';
import 'package:book_my_movie/presentation/widgets/custom_drawer.dart';
import 'package:book_my_movie/utils/common/exports.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeProvider>(context, listen: false).getMoviesResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: CommonAppBar.appBar('Book My Movie'),
      body: const SingleChildScrollView(
        primary: true,
        child: Column(children: [NowShowingComponent(), AllMovieComponent()]),
      ),
    );
  }
}
