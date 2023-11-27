import 'package:flutter/material.dart';

class HomeStatus extends StatefulWidget {
  @override
  State<HomeStatus> createState() => _HomeStatusState();
}

class _HomeStatusState extends State<HomeStatus> {
  final _formKeydealer = GlobalKey<FormState>();
  String? dropdowninitialValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Save Status'),
          bottom: const TabBar(
            isScrollable: false,
            tabs: [
              Tab(
                text: 'Viedo',
                // icon: Icon(Icons.video_camera_back),
              ),
              Tab(
                text: 'image',
                // icon: Icon(Icons.image),
              ),
              Tab(
                text: 'saved',
                // icon: Icon(Icons.save),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
          child: Form(
            key: _formKeydealer,
            child: TabBarView(
              children: [
                buildTab(0),
                buildTab(13),
                buildTab(17),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTab(int count) {
    if (count == 0) {
      return Center(child: const Text('Ther are no status available'));
      
    }
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.transparent),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: count,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                // color: Colors.amber,
                child: Center(child: Text('$index')),
              );
            }),
      ),
    );
  }
}
