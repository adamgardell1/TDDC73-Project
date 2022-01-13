# Getting started with flutter

**Author: Adam Gardell**

This guide will show you how to setup for app development in flutter and go through the basics of flutter and dart.

## Setting up and creating your project

### Installing flutter

To use flutter, you first need to have it installed. If you don’t, this guide [this guide](https://docs.flutter.dev/get-started/install) will show all the steps.

### IDE

Next, you need an IDE to write the code and run your app. For example Visual studio Code which is easy to use with flutter thanks to the features contained in its flutter and dart extensions. The app can run in a chrome window but you can also use a [virtual device created in Android studio](https://developer.android.com/studio/run/managing-avds).

### Create project

Now it’s time to create the flutter project. There are several ways to do this but let’s do it using a terminal in VSCode.  
In the terminal, navigate to the folder you want to create your project in and enter

```console
flutter create <project name>
```

This will create your project. In the file `main.dart` in the lib folder, you can find example code for an app that increments a counter when pushing a button. Try to run it in chrome or on a virtual device using the play button at the top right corner and choose start debugging.

## First look

The code contains a class named `MyApp` which is the root class and at the moment routes to the class `MyHomePage`. `MyHomepage` returns everything we see on the screen when running the example code.

### Callback function

The void function `_incrementCounter()` is a callback function that increments the class variable `_counter` and calls `setState()` to rebuild the Homepage widget to update the counter on screen.

### Widgets

A widget is a component in flutter that takes different input and creates content on screen. A widget can affect other widgets called children to behave a certain way. A widget above another widget in the tree is called a parent.

The `Scaffold` widget returned in the `MyHomePage` build is a way to create a structure for the screen, since it contains an app bar and the body of the page. Inside the Scaffold, there is a child `Center` which positions its one child in the middle of its parent (the scaffold in our case). Let's keep that widget.

The child of Center is `Column` which has one or more children and puts them after each other vertically. The size of the Column widget and the postitioning of its children can be changed, for example by `mainAxisAlignment: MainAxisAlignment.center` to place the children as close to the vertical center as possible. This column has two children: a `Text` widget with the message 'You have pushed the button this many times:' and another `Text` widget displaying the value of the counter. Let's delete these two children but keep the Column itself.

The last child that we find in this Scaffold is `FloatingActionButton` which has a plus `Icon` as child. The button also has an attrtibute called onPressed which calls _incrementCounter() when pushing the button, as explained earlier. Let's delete the FloatingActionButton as well, we can create another button later.

The code we are left with in the builder of MyHomePage should look something like this:

```dart
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
```

## Layout with Rows an Rolumns

Now that we have had a first look att the example code and removed some widgets, it's time to try to write some code ourselves. We start with creating a Text widget to display a counter. Under the counter we then want to create two buttons, increment and decrement, that we later will connect to the counter. Under the buttons we will put a button that navigates us to a second screen that only shows the counter.

If we draw the layout we get something like this:

               *Counter*
        *Decrement* *Increment*
               *Navigate*

This layout can be seen as column with 3 rows where the first and third row contains one column each and the second row has 2 columns. To create this we could use a `Column` widget where the second child is a `Row` widget with 2 children. We already have the Column ready so let's add its children inside the [] brackets. Each child is separated by a comma.

First we add The Text widget for the counter. Inside we want to display the value of the counter that we kept in the code. To display an integer value as a string, we wrap the variable with '$ '. We can also use some style on the text to increase its size.

This is what the code for the counter could look like:

```dart
Text(
    '$_counter',
    style: Theme.of(context).textTheme.headline1,
),

```

Next child in the Column is a Row , which works the same as the Column Widget. Inside the children brackets of Row we add 2 `TextButton` widgets after each other. The buttons should have an onPressed but we will get back to that soon. As child, we add an `Icon` to each button: 

```dart
Icon(Icons.remove, color: Colors.white),
```

for the decrease button and

```dart
Icon(Icons.add, color: Colors.white),
```

for the increase button.

To get a background color, we add a style to the buttons:

```dart
ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)
```

To get a better placement of the buttons we can use `mainAxisAlignment: MainAxisAlignment.center` in a similar way as for the column.

As the third and last child in the Column we will now add another TextButton with a Text 'Next page' as child. We add `Padding` around the Text to increase the size of the button background.

```dart
TextButton(
    child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
            'Next page',
            style: TextStyle(color: Colors.white),
        ),
    ),
    style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
    ),
)

```

Now we have all our widgets organized in Rows and Columns. One problem is the spacing between the widgets, we might want to add some space between them. THis can be done in several ways but an easy one is to add `SizedBox` widgets between our existing widgets and give them the width or height we want as space.

## Callback-functions

We now have our basic layout done, but the buttons doesn't do anything yet. The next step is to use functions when pushing our increase and decrease buttons to change the value of the counter and update the screen immediately to change the displayed counter.

We already have a finnished function `_incrementCounter()` so let's create a similar `_decrementCounter()` like this:

```dart
void _decrementCounter() {
    setState(() {
      _counter--;
    });
}
```

the void function decrements the counter variable and uses setState() to notify the app that the state of _counter has changed, which is the reason we can get it updated on screen.

Now we just add onPressed to our TextButtons and call our functions:

```dart
TextButton(
    onPressed: _decrementCounter,
    child: Icon(Icons.remove, color: Colors.white),
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
    ),
),
```

Now we should have working increase and decrease buttons, try it!

## Navigating between screens

Now it's time to implement The last button 'Next page'. We can do this using routing and then the `Navigator` to push our second route to the stack. First we need a second page to display, our second route. We create a new class called SecondPage that extends StatelessWidget (since the state won't change during run time for this page). The page should have a constant counter that is given a value when we call for the page. In the build we return a Scaffold with an appBar title of 'Page 2' to easily see when we change page. In the Center we only need a Text widget displaying the value of counter.

```dart
class SecondPage extends StatelessWidget {
  const SecondPage({Key key, @required this.counter}) : super(key: key);
  final int counter;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: Center(
        child: Text(
          '$counter',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
```

To navigate to this page we add an onPressed to the Next page button on our home page and use a Navigator:

```dart
onPressed: () {
    Navigator.push(context, MaterialPageRoute(
    builder: (context) => SecondPage(
         counter: _counter,
            ),
        ),
    );
},
```

This sets the counter on the second page to the value of the original counter and pushes SecondPage to the top of the stack. Try it!

## Final words

Thank you for reading my guide! Hopefully it was helpful. You can find all the code in the lib folder.
