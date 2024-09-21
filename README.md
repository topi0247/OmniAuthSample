# 環境構築
1. クローン & ディレクトリ移動
2. `docker compose build`
3. `docker compose run --rm web yarn install`
4. `docker compose up`

もしDBがないとか怒られたらDB作ったりなんだりしてください

## 環境変数
1. `.env`をルートに作成
2. 下記を記入

```
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

DISCORD_CLIENT_ID=
DISCORD_CLIENT_SECRET=

GITHUB_KEY=
GITHUB_SECRET=

LINE_CHANNNEL_ID=
LINE_CHANNEL_SECRET=
```
上記は値を入れたり変更したりするたびに`docker compose up`し直しが発生します。

## Google認証の設定
`https://console.cloud.google.com/`にアクセス

リダイレクトして下記の画面になったらOK
<img src="https://i.gyazo.com/c8bedfdde6abc30129b03b26220314a6.png" width="400px" />
「APIとサービス」を選択

ヘッダーからプロジェクトを選択（赤い丸、新規作成の場合は画面違うかも）
<img src="https://i.gyazo.com/d9239dd85a7a720d7f8583b13c7ff783.png" width="400px" />

ポップアップの右上「新しいプロジェクト」をクリック
<img src="https://i.gyazo.com/5edc1acf8a3c48f693e70757762d8513.png" width="400px" />

「プロジェクト名」を記入して「作成」ボタン（「場所」は「組織なし」でも大丈夫）
<img src="https://i.gyazo.com/64287849f1c204881a8969c48171ebaa.png" width="400px" />

右上通知欄で作成が完了したら「プロジェクトを選択」で作成したプロジェクトに移動 \
あるいはヘッダーからプロジェクトを選択してもOK
<img src="https://i.gyazo.com/51a79d23916e3fceab6cc10cd3e8f35f.png" width="400px" />

### OAuth同意画面
左カラムから「OAuth同意画面」を選択。\
「User Type」を「外部」にして作成
<img src="https://i.gyazo.com/ad6db7cfb299fb26dc724b0c38e1be49.png" width="400px" />

「アプリ名」「ユーザーサポートメール」「デベロッパーの連絡先情報」を記入して「保存して次へ」\
他の項目はあとから設定可能


スコープの項目は何も記入せず「保存して次へ」でOK

テストユーザーの項目も何も記入せず「保存して次へ」でOK

概要で確認して「ダッシュボードに戻る」

### 認証情報
左カラムから「認証情報」を選択。\
上の「認証情報を作成」から「OAuthクライアントID」を選択
<img src="https://i.gyazo.com/8494c8793a4bcf206fe26ecfee88c8aa.png" width="400px" />

アプリケーションの種類は「ウェブ アプリケーション」を選択\
名前は開発者側の識別用なので何でもOK\
**承認済みのJavaScript生成元**で「URIを追加」を押し`http://localhost:3000`を記入\
**承認済みのリダイレクトURI**で「URIを追加」を押し`http://localhost:3000/auth/google_oauth2/callback`を記入\
上記記入できたら「作成」\

**OAuthクライアントを作成しました**というポップアップが出たら、「クライアントID」と「クライアントシークレット」が表示されるので、それぞれ`.env`の環境変数にセット
```
GOOGLE_CLIENT_ID=クライアントID
GOOGLE_CLIENT_SECRET=クライアントシークレット
# 例
GOOGLE_CLIENT_ID=012345-abcdefg.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=ABCDE-Efhi01234
```
※`=`の後に空白を入れたり`"`で文字列を囲ったりする必要はないです。

上記で設定した後、必要に応じて`docker compose up`し直すと行けるハズ

## Discord認証
`https://discord.com/developers/applications`へアクセス\
※ログインしたあとは入れます

右上の「New Application」をクリック
<img src="https://i.gyazo.com/292f68e2e2694e7105c7105665cf6547.png" width="400px" />

ポップアップが出るのでアプリ名を入れる（ユーザーの認証でも表示されるもの）\
チェックボックスにチェックを入れて「Create」

左カラムから「OAuth2」を選択
<img src="https://i.gyazo.com/07c201a9d380706048e56e80056618c3.png" width="400px" />

**Client information**の「CLIENT SECRET」で「Reset Secret」をクリック\
確認が入るけれど「Yes, do it!」でOK\
**CLIENT ID**と**CLIENT SECRET**を環境変数にセット
<img src="https://i.gyazo.com/b7771afefb7f96cd13fb9e83590d516b.png" width="400px" />
```
DISCORD_CLIENT_ID=
DISCORD_CLIENT_SECRET=
例：
DISCORD_CLIENT_ID=123456789
DISCORD_CLIENT_SECRET=abcDEfga123
```
※`=`の後に空白を入れたり`"`で文字列を囲ったりする必要はないです。\
上記で設定した後、必要に応じて`docker compose up`し直すと行けるハズ

**Redirects**の「Add Redirect」をクリック
<img src="https://i.gyazo.com/921592ca36183ecd137626b1c1bf5791.png" width="400px" />
`http://localhost:3000/auth/discord/callback`を入力する。\
フォーカスが変わると下に「Save」ボタン出るのでSave
<img src="https://i.gyazo.com/c866050f499ea07cc34d2bcee3a86ddc.png" eidth="400px" />