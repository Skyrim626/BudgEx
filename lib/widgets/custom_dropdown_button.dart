import 'package:budgex/model/category_model.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({Key? key}) : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  late String selectedCategory;

  late List<String> items;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    items = List.generate(
        list_categories.length, (index) => list_categories[index]['name']);
    selectedCategory = items[0];
    _scrollController = ScrollController();

    // Generate current time
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDropDownMenu(context);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, left: 8.0, right: 8.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expense Category *',
                    style: TextStyle(
                        fontFamily: dosis['regular'],
                        color: LIGHT_COLOR_3,
                        fontSize: fontSize['h5']),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    selectedCategory,
                    style: TextStyle(fontFamily: poppins['semiBold']),
                  ),
                ],
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropDownMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  setState(() {
                    selectedCategory = items[index];
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }
}
