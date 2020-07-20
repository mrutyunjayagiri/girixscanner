import 'package:flutter/material.dart';
import 'package:girixscanner/www/grixcode/com/scopedModel/main_model.dart';
import 'package:girixscanner/www/grixcode/com/widgets/loader.dart';
import 'package:scoped_model/scoped_model.dart';

class GenerateButton extends StatelessWidget {
  final Function onGenerate;

  const GenerateButton({Key key, this.onGenerate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ScopedModelDescendant(
        builder: (_, __, MainModel model) {
          return model.isLoading
              ? Loader()
              : MaterialButton(
                  onPressed: () => onGenerate(model),
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 18.0),
                  textColor: Colors.white,
                  elevation: 0.0,
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text("GENERATE"),
                );
        },
      ),
    );
  }
}
