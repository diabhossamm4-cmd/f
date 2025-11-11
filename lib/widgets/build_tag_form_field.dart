import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildTagFromField extends StatelessWidget {
  final String hint;
  final List items;
  final Function onSubmit;
  final Function onRemove;
  BuildTagFromField({this.hint, this.items, this.onSubmit, this.onRemove});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10), vertical: ScreenUtil().setHeight(10)),
      decoration: BoxDecoration(
        color: mainColor.withOpacity(.15),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Icon(
            FontAwesomeIcons.file,
            color: mainColor,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Container(
            width: ScreenUtil().setWidth(1),
            height: ScreenUtil().setHeight(100),
            color: mainColor.withOpacity(.55),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Flexible(
            child: Tags(
              alignment: WrapAlignment.start,
              itemCount: items.length,
              textField: TagsTextField(
                  autofocus: false,
                  inputDecoration: InputDecoration(
                    hintMaxLines: 1,
                    contentPadding: EdgeInsets.only(top: 10),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  hintText: hint,
                  textStyle: TextStyle(
                    fontSize: 13,
                  ),
                  /*constraintSuggestion: true, suggestions: [],*/

                  //width: double.infinity, padding: EdgeInsets.symmetric(horizontal: 10),
                  onSubmitted: onSubmit),
              itemBuilder: (int index) {
                final item = items[index];
                return ItemTags(
                  index: index,
                  key: Key(index.toString()),
                  // color: Colors.white,
                  activeColor: mainColor,
                  color: mainColor,
                  textActiveColor: Colors.white,
                  textColor: Colors.white,
                  /* icon: ItemTagsIcon(
                            icon: Icons.add,
                          ),*/

                  removeButton: ItemTagsRemoveButton(
                    onRemoved: () {
                      // Remove the item from the data source.
                      onRemove(index);

                      //required
                      return true;
                    },
                  ),
                  //
                  onPressed: (item) => print(item),
                  onLongPressed: (item) => print(item),
                  //                   child: ItemTags(
                  title: item,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
