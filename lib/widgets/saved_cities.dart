import 'package:flutter/material.dart';
import 'package:http/http.dart';

// SavedCityList widget helps to Manages city query,add,deletion operations
class SavedCityList extends StatefulWidget {
  final String cityName;
  final Function() onTap;
  final Function() onPressEvent;

  const SavedCityList({
    super.key,
    required this.cityName,
    required this.onTap,
    required this.onPressEvent,
  });

  @override
  State<SavedCityList> createState() => _SavedCityListState();
}

class _SavedCityListState extends State<SavedCityList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressEvent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cityName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              IconButton(
                  onPressed: widget.onTap,
                  icon: Icon(
                    Icons.delete,
                    size: 28,
                    color: Colors.red,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
