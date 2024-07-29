# プロジェクト名

Linux 風 PowerShell （パワーシェル）プロファイル

## 目的

著者はもともとLinuxかMacで開発勉強してたので、慣れない PowerShell のプロファイルを Linux 風にして使いやすくしました。

## 設定内容

ウィドウタイトルをカレントディレクトリを表示する。
プロンプトもカレントディレクトリのみを表示する。
git の状態をプロンプトに表示する。
git buranch 名をプロンプトに表示しる。
デフォルトでホームディレクトリから開始する。


```ps
[workspace] >
[codebase] (main) * > //コミット判定 False
[codebase] (main) > 　//コミット判定 Clean

```

## インストール
始める前に、既にプロファイルがある場合は、バックアップする事をお勧めします。
```ps
Copy-Item -Path $PROFILE -Destination "$PROFILE.bak"
```

1. PowerShell を開いて、次のコマンドでプロファイルの場所を表示します。
```ps
$PROFILE
```
2. プロファイルファイルのパスがかえされるので、エクスプローラで開きます。
3. プロファイルがない場合は次のコマンドをターミナルから実行して空のプロファイルを作成することができます。
```ps
if (!(Test-Path -Path $PROFILE)) {
    New-Item -Type File -Path $PROFILE -Force
}
```
4. 空のプロファイルを作成したら。または、既存のプロファイルを本リポジトリの `Microsoft.PowerShell_profile.ps1`と置き換えるか、用途に合わせて編集します。
```ps
"Microsoft.PowerShell_profile.ps1"
```
5. 変更内容は、ターミナルを再起動するか次のコマンドを実行して反映できます。
```
. $PROFILE
```

以上

## ライセンス

このプロジェクトは [MIT](https://opensource.org/licenses/MIT) のもとで公開されています。詳細は [LICENSE.txt](LICENSE.txt) を参照してください。

## お問い合わせ

質問やフィードバックは [meicha365@pm.me](meicha365@pm.me) までお願いします。
