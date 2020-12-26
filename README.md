# Paster
Paster is a menu bar app that optimizes text for machine translation.
Japanese document is available [here](http://yebityon.hatenablog.com/entry/2020/03/07/161614).

## Features
1. Removes newlines
Some translators don't work well for English sentence which is copied from two-column paper.
This is caused by newline characters (i.e. `"\r"` and `"\n"`, also known as CR and LF).

2. Shows word count
It shows the word count of the text in the clipboard.
It applies the appropriate counting method based on the text language.
Currently, English and Japanese are supported.

## Install
Paster ver2.0 has been released!!

1. Download `Paster.zip` from [the Release page](https://github.com/yebityon/Paster/releases).
2. In the Finder on your Mac, find the app you want to open.
3. Control-click the app icon.
4. Choose `Open from the shortcut menu`.
5. Click `Open`.

This instruction exists because I have not enrolled in the apple developer program yet.

References:
* https://support.apple.com/ja-jp/guide/mac-help/mh40616/mac (JP)
* https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac (En)

## Help!
I am a newbie programmer, so Paster might have serious bugs.
I need your help. If you notice something, please submit an issue or create a pull request.
