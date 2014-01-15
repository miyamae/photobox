写真を撮影日時別のディレクトリに振り分けるプログラムです。
Exif撮影日時が入っていないファイルは、ファイル更新日で振り分けます。

使用例

    $ photobox.rb ~/Desktop *.jpg
    > /Users/miyamae/Desktop/20140101/P1110903.jpg
    > /Users/miyamae/Desktop/20140101/P1110904.jpg
    > /Users/miyamae/Desktop/20140101/P1110905.jpg
