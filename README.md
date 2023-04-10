# besso_log_book

Flutter 別荘に遊びに行った訪問者が、訪問と思い出の記録のために写真とひとことを残し、それを一覧できる Flutter Web のアプリケーション。

## 開発

FVM を使用します。

```shell
fvm install
fvm flutter pub get
```

Git トラッキングしているので VS Code を使用している場合は特に設定は必要ありません。Android Studio の場合は `.vscode/settings.json`, `.vscode/launch.json` の内容を参考に同等の設定を行ってください。

## 設計

本アプリケーションは基本的に MVC のアーキテクチャに従うシンプル（で時々少し冗長）な設計で開発します。

ここで説明される設計が普遍的にベストだということは全くありませんが、アーキテクチャや書き方のルールの単純さ、許容できる程度の冗長さ、テストしやすさ、それなりの Riverpod らしさなどの観点において、程よい塩梅と言えるようなものだと思われます。

MVC と Flutter および本アプリケーションで使用されているパッケージなどの対応をざっくりと抽象的に述べると次のようになります。

- Model: アプリケーションの振る舞いを表現するもの。UI (View + Controller) 以外のすべて。
- View: Flutter のウィジェット、ディスプレイに表示される見た目。
- Controller: ユーザー操作を解釈して Model を操作したり、モデルを UI に反映させるもの。Riverpod の Provider で提供される（かんたんなものなら `StatefulWidget` を採用しても良い。）。ユーザーに Model の操作を直接させず、必ず Controller を介させることとする。

### ディレクトリ名やファイル名について

`lib` 以下のディレクトリは基本的に機能や関心事ごとに切ります。たとえば本アプリケーションの中心となる機能である「訪問者の記録」に関するソースコードは `lib/visitor_log` の中にあります。

```plain
lib
└── visitor_log
    ├── ui
    │   ├── visitor_log_controller.dart
    │   ├── visitor_log_create.dart
    │   ├── visitor_log_detail.dart
    │   └── visitor_logs.dart
    └── visitor_log.dart
```

`visitor_log` の直下には `visitor_log.dart` というファイルがあり、訪問記録に関するモデル、つまり UI 以外 (View + Controller) のソースコードが配置されています。

また `ui` というディレクトリも切られており、その名の通り UI (View + Controller) に関するソースコードが配置されています。

たとえば `visitor_logs.dart` には訪問者一覧画面の View が記述されています。ディレクトリ名から明らかなので特にファイル名 "page" や "screen" のような接尾辞はつけていません。

また、`utils`, `common`, `shared` のようなディレクトリを作りたくなることもよくありますが、そこにどのようなコードが配置されるべきか不明確になるので、本当に必要性が生じるまで作成せず、とりあえず `lib` の直下においてください。

### Cloud Firestore

`lib` の直下に `firestore` というディレクトリが切られています。

本アプリケーションは Cloud Firestore を使用していますが、本来アプリケーションは、接続先のサーバやデータソースが Cloud Firestore なのかその他の何なのかを知る必要がありません。その意味合いを込めて Cloud Firestore だけに関係する色々は `lib/firestore` ディレクトリに配置されています。

`firestore_models` ディレクトリは、"Model" という名前がついていますが MVC における "Model" というわけでもなく、単に Cloud Firestore に保存されるドキュメントのスキーマを Dart で記述しているような内容です。採用は必須ではないですが、自動生成が楽であるというくらいの理由で freezed パッケージを使用しています。`fvm flutter pub run build_runner watch --delete-conflicting-outputs` を走らせながら開発します。

`firestore_refs.dart` には、Cloud Firestore のすべてのコレクションとドキュメントへの参照 (`CollectionReference`, `DocumentReference`) が型付きでひとつのファイルに記述されています。

`firestore_repository.dart` では、Cloud Firestore への単純な読み書きを定義します。

Cloud Firestore のドキュメントと Dart の変数・インスタンスとの変換に必要な json_converter なども同じく `lib/firestore` ディレクトリに集めています。

## auto_route

ルーティングについては、人気が高まっており十分な機能が提供されているので、[auto_route](https://pub.dev/packages/auto_route) パッケージを使用しています。使用方法はパッケージの README を読んでください。関連するコードは主に `lit/router` に記述されています。

また、ルーティングの対象であるウィジェット（いわゆる "ページ" を表すウィジェット）は、`@RoutePage()` というアノテーションを付けた上で、以下のようにクラス名の末尾を `Page` とすると、`fvm flutter pub run build_runner watch --delete-conflicting-outputs` によって自動で `lib/router/router.gr.dart` のコードが生成し直されます。

```dart
@RoutePage()
class FooPage extends StatelessWidget {
  // 省略
}
```

### Riverpod

Riverpod の `FutureProvider` や `StreamProvider` などの各種の Provider を "Riverpod らしく" 活用して、再利用性の高いコンポーネントベースな設計をすることも、あえて使用する Provider を `StateNotifierProvider` に寄せていわゆる MVVM っぽく設計することも、また Riverpod の機能をフルに活用したインジェクションを行うことなどもできますが、本アプリケーションでは設計の分かり易さと享受できるメリットのバランスを考えて、その中間的な使用方法をします。

#### インジェクションについて

すべてコンストラクタ DI とします。また `ref` (`ProviderRef`) を丸ごと渡すことは禁止として、使用するクラスを明示的に渡します。`Riverpod` らしさをやや損なう冗長な記述となりますが、インジェクションの内容の明確化と単純なルールでそれを統一できること、`ProviderScope` などを使わずにユニットテストができることなどからそのようにします。

#### Provider の使い分けについて

単に（Cloud Firestore の）データを取得または購読するような処理においては、`FutureProvider` や `StreamProvider` を活用します。わざわざ `StateNotifier` などを定義していわゆる MVVM っぽい書き方にするのは冗長だからです。

たとえば（Cloud Firestore の）訪問者ログ一覧を購読する `StreamProvider` は次のようになります。

```dart
final visitorLogs = StreamProvider.autoDispose<List<VisitorLog>>((ref) {
  final service = ref.watch(visitorLogService);
  return service.subscribe();
});
```

こうすることで、`Service` クラスを通じて得られたデータを、`ViewModel` の変数に格納するのではなく、単にウィジェットの `build` メソッドの中で `ref.watch` すれば、さらには `.when` すれば良いのでかんたんです。

書き込み系の操作や、複雑なユーザー操作を解釈するような操作は、Controller が担当することなので、`FooController` というクラスを定義してそのメソッドとしてそれらの操作を記述し、Controller クラスのインスタンスは素の `Provider` 経由で使用できるようにします。次のような感じです。

```dart
class VisitorLogController {
  VisitorLogController({required VisitorLogService service})
      : _service = service;

  final VisitorLogService _service;

  Future<void> create() async { /** 省略 */}
}
```

#### その他

その他は既存のコードを参考にしてください。
