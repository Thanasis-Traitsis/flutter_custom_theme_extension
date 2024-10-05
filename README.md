# Mastering Custom Container Themes in Flutter
![Header](https://github.com/Thanasis-Traitsis/flutter_custom_theme_extension/blob/main/assets/Mastering%20Custom%20Widget%20Themes%20in%20Flutter.png?raw=true)
Well hello there Flutter people. It's been a while since my last blog post, but I'm back with something very interesting that will level up your Flutter applications. Today's subject is **Custom Container Themes**, a powerful way to manage consistent, reusable styling throughout your app.

Ever found yourself copying and pasting container styles throughout your app? Sure, creating a Stateless Widget might seem like a quick and easy fix, but there's a more clean, maintainable solution hiding in Flutter's theming system.

In this tutorial, we'll explore how to:

- Create custom container themes within ThemeData.
- Define reusable style variables (colors, text sizes, etc.).
- Implement responsive design principles using themes.
- Keep your code DRY (Don't Repeat Yourself) and maintainable.

By the time you finish reading this post, you'll have a new tool in your Flutter toolbelt for creating more consistent, scalable UI designs. Let's dive in!

## 🎨 Setting Up Theme Values

Before we dive into custom container themes, we need to establish a foundation of consistent values that we'll use throughout our application. This approach ensures visual consistency and makes future updates much easier to manage.

Let's create a file and call it `app_values.dart`. This file will store all our standard values and looks like this:
```dart
class AppValues {
  final double smallText = 10.0;
  final double normalText = 12.0;
  final double largeText = 24.0;

  final double pokecardBorderRadius = 20;
  final double pokecardPadding = 10;
}
```

Next, create a `colors.dart` file to define our color scheme:
```dart
class AppColors {
  final Color grassBackgroundColor;
  final Color grassTextColor;
  final Color grassOutlineColor;

  AppColors({
    required this.grassBackgroundColor,
    required this.grassTextColor,
    required this.grassOutlineColor,
  });

  static final mainColors = AppColors(
    grassBackgroundColor: const Color(0xffcef79f),
    grassTextColor: const Color(0xff2a513f),
    grassOutlineColor: const Color(0xff378e8e),
  );
}
```

Now, with these two files perfectly setup, it's time to create our ThemeData. Create a file, name it `app_theme.dart` and include this class:
```dart
class AppTheme {
  final AppColors chosenColor;

  AppTheme(
    this.chosenColor,
  );

  ThemeData getTheme() {
    final values = AppValues();

    return ThemeData(
      useMaterial3: true,
      // You can add your own appbar style, background color, primary color etc...
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: values.largeText,
          color: chosenColor.grassTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
```

Why This Matters:

- Consistent color usage enhances your app's visual coherence.
- Using semantic color names (like 'grassBackgroundColor') makes your code more maintainable.
- The factory constructor pattern allows for easy theme switching if needed.

By the way, if you are paying attention on the variable names, I think you know what's the main topic of this tutorial...

## Custom Theme Extension

Let's dive into the main reason you clicked on this tutorial. The scenario of this application is that I want to showcase every Grass-type Pokémon inside its own card. This card will be the same for every Pokémon, so there is no need to build the same widget continuously. Instead, let’s create a theme to define every Grass-type card:

```dart
class GrassTypeTheme extends ThemeExtension<GrassTypeTheme> {
  final Color backgroundColor;
  final Color textColor;
  final Color outlineColor;
  final EdgeInsets cardPadding;
  final BorderRadius cardBorderRadius;

  GrassTypeTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.outlineColor,
    required this.cardPadding,
    required this.cardBorderRadius,
  });
}
```

That's the foundation of our Theme. What makes this situation particularly noteworthy is the inheritance of the class, because it extends the **ThemeExtension**. That's the key of the whole tutorial. To properly implement this extension, we need to focus on two critical steps: <br>

**Step 1: Implement the `copyWith` Method** <br>
The `copyWith` method is crucial for our custom theme. It allows us to create new instances of our theme by overriding specific properties. This is useful when you want to create variants or update only a few values dynamically.

Let’s add it to our class:
```dart
@override
  ThemeExtension<GrassTypeTheme> copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? outlineColor,
    EdgeInsets? cardPadding,
    BorderRadius? cardBorderRadius,
  }) {
    return GrassTypeTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      outlineColor: outlineColor ?? this.outlineColor,
      cardPadding: cardPadding ?? this.cardPadding,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
    );
  }
```
**Step 2:  Implement the `lerp` Method**<br>
The lerp method (linear interpolation) is essential when animating theme changes or transitioning between different theme states. It helps Flutter animate changes smoothly when switching themes.

Here’s how you can implement it:
```dart
 @override
  ThemeExtension<GrassTypeTheme> lerp(
      covariant ThemeExtension<GrassTypeTheme>? other, double t) {
    if (other is! GrassTypeTheme) return this;
    return GrassTypeTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      outlineColor: Color.lerp(outlineColor, other.textColor, t)!,
      cardPadding: EdgeInsets.lerp(cardPadding, other.cardPadding, t)!,
      cardBorderRadius:
          BorderRadius.lerp(cardBorderRadius, other.cardBorderRadius, t)!,
    );
  }
```

With these two methods (copyWith and lerp) in place, your custom theme is now complete and ready to be used!

## 🔧 Completing The App Theme

You are one step away of completing the most responsive and maintainable application setup you ever created. We just need to add the extension we just built into our ThemeData. Here's the code:

```dart
class AppTheme {
  final AppColors chosenColor;

  AppTheme(
    this.chosenColor,
  );

  ThemeData getTheme() {
    final values = AppValues();

    return ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: values.largeText,
          color: chosenColor.grassTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      // There is the ThemeExtension we created
      extensions: <ThemeExtension<dynamic>>[
        GrassTypeTheme(
          backgroundColor: chosenColor.grassBackgroundColor,
          textColor: chosenColor.grassTextColor,
          outlineColor: chosenColor.grassOutlineColor,
          cardBorderRadius: BorderRadius.circular(values.pokecardBorderRadius),
          cardPadding: EdgeInsets.all(values.pokecardPadding),
        ),
      ],
    );
  }
}
```

The power of our theming system lies in its flexibility. Since the extension property is a List, you can define multiple themes to suit your needs. With our foundation in place, all that's left is to create a Widget that leverages our carefully crafted theme.

```dart
class CustomContainer extends StatelessWidget {
  final String text;
  final String img;

  const CustomContainer({
    super.key,
    required this.text,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    final containerTheme = Theme.of(context).extension<GrassTypeTheme>();

    return Container(
      width: 300,
      height: 200,
      padding: containerTheme?.cardPadding,
      decoration: BoxDecoration(
        borderRadius: containerTheme?.cardBorderRadius,
        color: containerTheme?.backgroundColor,
        border: Border.all(
          width: 4,
          color: containerTheme!.outlineColor,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned(
            left: 100,
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.network(img),
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
```

When you implement this widget in your app, you'll see the theme come to life, automatically adapting to any theme changes you make. For now, let's enjoy our beautiful Bulbasaur card that we created with such quality code. <br>
<img src="https://github.com/Thanasis-Traitsis/flutter_custom_theme_extension/blob/main/assets/home_screen.png?raw=true" alt="Home Screen" width="300" height="auto">

## Conclusion

And there you have it! We've unlocked a new level of customisation that goes much beyond basic color schemes by utilising Flutter's ThemeExtension. This approach enables us to create rich, deeply customizable themes that can hold any design property we need - from padding and border radius to complex color palettes and more.

The next time you find yourself reaching for hard-coded styles or repetitive design code, consider leveraging ThemeExtension to create a more elegant, maintainable solution. Happy theming!

If you enjoyed this article and want to stay connected, feel free to connect with me on [LinkedIn](https://www.linkedin.com/in/thanasis-traitsis/).

If you'd like to dive deeper into the code and contribute to the project, visit the repository on [GitHub](https://github.com/Thanasis-Traitsis/flutter_custom_theme_extension).

Was this guide helpful? Consider buying me a coffee!☕️ Your contribution goes a long way in fuelling future content and projects. [Buy Me a Coffee](https://www.buymeacoffee.com/thanasis_traitsis).

Feel free to reach out if you have any questions or need further guidance. Cheers to your future Flutter projects!
