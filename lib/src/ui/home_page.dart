import 'package:flutter/material.dart';
import 'package:university_list/src/model/university_model.dart';
import 'package:university_list/src/viewmodel/university_list_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../network/util/api_response.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget getUniversityList(BuildContext context, ApiResponse apiResponse) {
    List<UniversityModel>? dataList =
        apiResponse.data as List<UniversityModel>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(
          child: CircularProgressIndicator(),
        );

      case Status.ERROR:
        return const Center(
          child: Text('Please try again later!'),
        );

      case Status.COMPLETED:
        return Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: dataList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('${dataList?[index].name}'),
                    leading: Text('${dataList?[index].alphaTwoCode}'),
                    subtitle: InkWell(
                        onTap: (() => _launchUrl(dataList?[index].webPages[0])),
                        child: Text(
                          '${dataList?[index].webPages[0]}',
                          style: const TextStyle(color: Colors.blue),
                        )),
                  );
                },
              ),
            ))
          ],
        );

      case Status.INITIAL:
      default:
        return const Center(
          child: Text('Search university'),
        );
    }
  }

  void _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    final _countryController = TextEditingController();
    ApiResponse apiResponse =
        Provider.of<UniversityViewModel>(context).response;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find University'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                      controller: _inputController,
                      onChanged: (value) {},
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          Provider.of<UniversityViewModel>(context,
                                  listen: false)
                              .fetchUniversityList(value, "");
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search University',
                      )),
                ),
                Flexible(
                  child: TextField(
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                      controller: _countryController,
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'enter country',
                      )),
                ),
                IconButton(
                    onPressed: () {
                      if (_inputController.text.isNotEmpty) {
                        // Provider.of<UniversityViewModel>(context, listen: false)
                        //     .setSelectedItem(null);
                        Provider.of<UniversityViewModel>(context, listen: false)
                            .fetchUniversityList(
                                _inputController.text, _countryController.text);
                      }
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
          Expanded(child: getUniversityList(context, apiResponse)),
        ],
      ),
    );
  }
}
