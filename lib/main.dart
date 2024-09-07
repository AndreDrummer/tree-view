import 'package:tree_view/controller/controller.dart';
import 'package:tree_view/widgets/tree_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Controller(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool called = false;

  void callOnce(VoidCallback call) {
    if (!called) {
      call();
      setState(() {
        called = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    // callOnce(() {
    //   Provider.of<Controller>(context, listen: false).filterByMaleGender();
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            Consumer<Controller>(
              builder: (context, controller, _) {
                return Column(
                  children: [
                    CheckboxListTile(
                      value: controller.genderTypeFilter == controller.male,
                      onChanged: (value) {
                        controller.filterByMaleGender();
                      },
                      title: const Text(
                        "Male",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    CheckboxListTile(
                      value: controller.genderTypeFilter == controller.female,
                      onChanged: (value) {
                        controller.filterByFemaleGender();
                      },
                      title: const Text(
                        "Female",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    TreeView(
                      controller.root,
                      toggleNodeView: (node) {
                        controller.toogleNodeView(node);
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
