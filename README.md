Custom Font Loading Demo
========================

A sample application for demoing the initial lag of loading a custom font in iOS 8.

This application uses the Oswald font from [Google Fonts](http://www.google.com/fonts/).

The purpose of this demo is to show the lag when initially loading custom fonts with this mechanism:
```
UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName
                                                                       size:pointSize];

UIFont *font = [UIFont fontWithDescriptor:fontDescriptor size:0];
```

It's important to note that the lag is only present during the first request for your custom font. Subsequent requests using this mechanism are much faster (and what I would expect).

I have noticed that this lag is not present if you load a custom font with this mechanism:
```
UIFont *font = [UIFont fontWithName:fontName size:pointSize];
```

This has been submitted to Apple as [rdar://18828662](rdar://18828662).
