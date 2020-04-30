# custom_sheet

This package aims to help you displaying a quick colored modal bottom sheet. You can use it to display a few types: loading; title and body; title, body and buttons; customized. The main role of this package is to create a modal bottom sheet with a custom color and the colors of the text and the buttons will be based on the luminance of the color provided (or your current ascent color from your theme, if the color is not provided).
<p align="center">
  <img  src="screenshots/0.gif?raw=true">
</p>


## Getting Started


### How to use?

Add this to your package's pubspec.yaml file:

```
dependencies:
  custom_sheet:
```

**Attention!** 

The Flutter stable branch didn't implement the drag option on the modal bottom sheet, so I had to add this capability. Hence, **add this if your using the stable flutter channel**. 

```
dependencies:
  custom_sheet:
    git:
      url: git://github.com/madtocc/custom_sheet.git
      ref: stable
```

Import it:
```dart
import 'package:custom_sheet/custom_sheet.dart';
```

To use it create an instance of the CustomSheet class (the context is required) and set the optional parameters (if you want):

```dart
CustomSheet(context,
    Color sheetColor,
    Color secondColor,
    Color textColor,
    Color subTextColor,
    double secondColorPercent
);
```
You can set some custom parameters:

 Parameter | Description |
|---|---|
|Color sheetColor | The `sheetColor` is the color of your modal bottom sheet. If it is not set it will be your current ascent color from your theme.|
|Color secondColor | The `secondColor` is the color of the buttons and the body (optional). By default will be a color sligthly darker or lighter than the color provided on the sheetColor. This color is computed based on the luminance of the `sheetColor`. Otherwise it will be the color provided.|
|Color textColor | The `textColor` is the text color of the title. By default will be black if the luminance of the `sheetColor` is light or white if its luminance is dark. Otherwise it will be the color provided.|
|Color subTextColor | The `subTextColor` is the text color of your buttons and body (optional). By default it will be black if the luminance of the `secondColor` is light or white if its luminance is dark. Otherwise it will be the color provided.|
|double secondColorPercent | The `secondColorPercent` is how much darker/lighter the second color will be. You can pick a value between 0 and 0.49. The default value is 0.1.|

In order to show the modal bottom sheet you'll have to call the method according to what you want to display. There are a few options parameters as well:
| Parameter | Description |
|---|---|
|bool isDismissible | The `isDismissible` specifies whether the bottom sheet will be dismissed when user taps outside of the bottom sheet. |
|bool blockBackButton | The `blockBackButton` will block when android users use the back button. |
|bool enableDrag | The `enableDrag` specifies whether the bottom sheet can be dismissed by swiping downwards. |

The default value of these parameters may be different for some methods, for instance when displaying a loading I want to make the bottom sheet undissmissable, block the back button and disable the drag. For the other methods it will be the opposite, but you can change it as you wish.

#### Display a Loading

```dart
void showLoading({
    String loadingMsg= "Loading ...", 
    bool isDismissible=false, 
    bool block=true, 
    bool enableDrag=false
});

```

```dart
// ----------------------------------------------------------------------------
// #1
// Create a simple loading with your current ascent color (theme)
// if the loading is not dismissable, has the back bottom blocked and the drag is disabled the only way to dismiss it is using the dismiss function or using Navigator.of(context).pop()
final cSheet = CustomSheet(context);
cSheet.showLoading();
// do something and then dismiss it...
cSheet.dismiss(milliseconds:2000);
// ----------------------------------------------------------------------------
//#2
// Create a simple loading with custom text [wait for it], custom text color [yellow] and custom sheet color [red]
final cSheet2 = CustomSheet(context,sheetColor: Colors.red,textColor: Colors.yellow);
cSheet2.showLoading(loadingMsg: "Wait for it ...");
// do something and then dismiss it...
cSheet2.dismiss(milliseconds:2000);
// ----------------------------------------------------------------------------
//#3
// create a loading style which can only be dismissed by swipping downward. i.e. pressing back button or clickin outside of the bottom sheet won't dismiss it
CustomSheet(context).showLoading(loadingMsg: "swipe-down to dismiss",enableDrag: true);

```


|  #1 |  #2 |  #3 |
|---|---|---|
|<img src="screenshots/1.gif?raw=true">| <img src="screenshots/2.gif?raw=true">| <img src="screenshots/3.gif?raw=true">|

#### Title and body
```dart
Future<void> showTitleBody({
    String title,
    String body,
    bool isDismissible = true,
    bool blockBackButton = false,
    bool enableDrag = true,
    bool bodySecondColorEnabled = false
});
          ```
```dart
// ----------------------------------------------------------------------------
// #4
// Create Title and Body with your current ascent color (theme)
CustomSheet(context).showTitleBody(
    title:"Welcome",
    body:"Lorem ...."
);
// ----------------------------------------------------------------------------
//#5
// Create a Title and Body witch custom sheet color [black]
// the text color will change according to its luminance, so it will be white right now.
CustomSheet(context,sheetColor: Colors.black).showTitleBody(
    title:"Welcome",
    body:"Lorem ...."
);
// ----------------------------------------------------------------------------
//#6
// Create a Title and Body witch custom sheet color [black] and custom body color [white]
// the text color will change according to its luminance, so it will be white for the title and black for the body.
CustomSheet(context,sheetColor: Colors.black,secondColor: Colors.white).showTitleBody(
    title:"Welcome",
    body:_"Lorem ....",
    bodySecondColorEnabled: true // the second color is used for the button colors, but we can change the body color setting this parameter to true
);
// ----------------------------------------------------------------------------
//#7
// Create a Title and Body witch custom sheet color [black], title color green, custom body color [white] and body text color red.
CustomSheet(context,sheetColor: Colors.black,secondColor: Colors.white,textColor: Colors.green,subTextColor: Colors.red).showTitleBody(
    title:"Welcome",
    body: "Lorem ...."
    bodySecondColorEnabled: true 
);

```


|  #4 |  #5 |  #6 |  #7 |
|---|---|---|---|
|<img src="screenshots/4.gif?raw=true">| <img src="screenshots/5.gif?raw=true">| <img src="screenshots/6.gif?raw=true">| <img src="screenshots/7.gif?raw=true">|

#### Title, body and buttons
```dart
Future<T2> showTitleBodyButtons<T1,T2>(
    {String title,
    String body,
    List<T1> options,
    double buttonHeight,
    bool isDismissible = true,
    bool blockBackButton = false,
    bool enableDrag = true,
    bool bodySecondColorEnabled = false
});
```

```dart
// ----------------------------------------------------------------------------
// #8
// Create Title and Buttons with your current ascent color (theme) and show the option selected on a snackbar
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
CustomSheet(context).showTitleBodyButtons(
    title:"Welcome",
    options: <OptionButton>[
    OptionButton("option 1",(){}),
    OptionButton("option 2",()=>Navigator.of(context).pop(true)),
    OptionButton("option 3",()=>Navigator.of(context).pop("3"))
    ]
)// do something with the popped value
.then((value) =>scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("$value",style:TextStyle(fontSize: 150)),duration: Duration(milliseconds: 750))));

// ----------------------------------------------------------------------------
// #9
// Create Title and Buttons with your current ascent color (theme), button color as blue grey, 150px button height and show the option selected on a snackbar
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
CustomSheet(context,secondColor: Colors.blueGrey).showTitleBodyButtons(
    title:"Welcome",
    options: <OptionButton>[
    OptionButton("option 1",(){}),
    OptionButton("option 2",()=>Navigator.of(context).pop(true)),
    OptionButton("option 3",()=>Navigator.of(context).pop("3"))
    ],
    buttonHeight: 150
)// do something with the popped value
.then((value) =>scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("$value",style:TextStyle(fontSize: 150)),duration: Duration(milliseconds: 750))));

// ----------------------------------------------------------------------------
//#10
// Create a Title and Body witch custom sheet color [black] with custom buttons
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
// You can create a custom widget or use an existing one, do it as you wish...
class MyCustomButton extends StatelessWidget{ 
      final Color color;
      final String text;
      final VoidCallback onTap;
  MyCustomButton(this.color, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Container(
      color:color,
      width:double.infinity,
      height:100,
      child:FlatButton(
        child: Text(text) ,
        onPressed: onTap,)
    );
  }
}
// thenn invoke the modal bottom sheet using your class MyCustomButton or whatever widget you want (Text,RaisedButton, etc)
CustomSheet(context,sheetColor: Colors.black).showTitleBodyButtons(
      title:"Welcome",
      options: <MyCustomButton>[
        MyCustomButton(Colors.red,"option 1",(){}),
        MyCustomButton(Colors.green,"option 2",()=>Navigator.of(context).pop(true)),
        MyCustomButton(Colors.purple,"option 3",()=>Navigator.of(context).pop("3")),
      ]
)// do something with the popped value
.then((value) =>scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("$value",style:TextStyle(fontSize: 150)),duration: Duration(milliseconds: 750))));

```
|  #8 |  #9 |  #10 |
|---|---|---|
|<img src="screenshots/8.gif?raw=true">| <img src="screenshots/9.gif?raw=true">| <img src="screenshots/10.gif?raw=true">|

#### Custom
```dart
Future<T2> showBS<T1,T2>({
    Widget top,
    Widget body,
    List<T1> options,
    bool isDismissible = true,
    bool blockBackButton = false,
    bool enableDrag = true,
    double buttonHeight=65
});
```
You can also customize the whole bottom sheet as you wish...

```dart
CustomSheet(context).showBS(
    top: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(Icons.ac_unit)),
    body: Text("THIS IS A CUSTOM LAYOUT..."),
    options: <SizedBox>[
        SizedBox(width:double.infinity,child:Icon(Icons.create,size: 100,)),
        SizedBox(width:double.infinity,child:Text("IT IS",textAlign: TextAlign.center)),
        SizedBox(width:double.infinity,child:Text("UP TO YOU!!",textAlign: TextAlign.end,)),
    ]
);
```
|  #11 | 
|---|
<img src="screenshots/11.gif?raw=true">