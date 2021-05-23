---

title: "【Rust+WebAssembly(wasm)】ゲームライブラリMacroquad使おうその1"  
date: 2021-05-23T6:00:00+09:00  
draft: false  
tags: [Rust, WebAssembly, Macroquad]  
categories: [Rust]  

---

Rustのクロスプラットフォーム対応ゲームライブラリである**Macroquad**が面白そうなので、使い方をまとめたいと思います。  
公式サイトはこちら。 https://macroquad.rs

# 前提
1. Rustが導入済みであること  
→ [導入方法](https://rustup.rs)

# 環境
- OS:Windows 10
- rustc 1.50.0 (cb75ad5db 2021-02-10)
- cargo 1.50.0 (f04e7fab7 2021-02-04)
- rustup 1.24.2 (755e2b07e 2021-05-12)
- toolchain:stable-x86_64-pc-windows-gnu

# Macroquadとはそもそも何？
Rust製のゲーム用ライブラリであり、クロスプラットフォーム(Web、Windows、Mac、Linux、Android、iOS)に対応しておりシンプルなコードですぐに実行出来るのが特徴です。  
。まずは以下のURL先のExampleをいろいろ触ってみましょう。  
https://macroquad.rs/examples/

今回、Macroquadを使ってWebAssembly出力し、ブラウザ表示をさせるのを目標とします。  


出力結果は以下の画像のリンク先のとおりです。

[{{< figure src="1.png" alt="Basic shapes" >}}](https://eda3.github.io/rustwasm/8/)
リポジトリ: https://github.com/eda3/rustwasm/tree/master/8

# ビルドを行う、確認する
基本的には、[githubのREADME記載通り](https://github.com/not-fl3/macroquad#readme)にいきます。

1. プロジェクトの作成を行う  
※今回、プロジェクトの名前は**basicshapes**にします
    ```shell
    cargo init --bin
    or
    cargo new basicshapes
    ```
2. cargo.tomlを修正し、macroquadを依存関係に加えます
   ```toml
   [dependencies]
   macroquad = "0.3"
   ```
3. macroquadのコードを記載します
   ```rust
   use macroquad::prelude::*;

   #[macroquad::main("BasicShapes")]
   async fn main() {
      loop {
         // 背景色を薄灰色に設定
         clear_background(LIGHTGRAY);

         // 青い棒を描画
         draw_line(40.0, 40.0, 100.0, 200.0, 15.0, BLUE);

         // 緑の四角を描画
         draw_rectangle(screen_width() / 2.0 - 60.0, 100.0, 120.0, 60.0, GREEN);

         // 黄色い丸を描画
         draw_circle(screen_width() - 30.0, screen_height() - 30.0, 15.0, YELLOW);

         // 濃灰色で文字を描画
         draw_text("HELLO", 20.0, 20.0, 30.0, DARKGRAY);

         next_frame().await
      }
   }
   ```
4. wasm形式でビルドを行います
   ```shell
   rustup target add wasm32-unknown-unknown

   # ローカル環境で確認を行う場合
   cargo build --target wasm32-unknown-unknown
   # 以下にwasmファイルが出力されます
   # basicshapes/target/wasm32-unknown-unknown/debug/basicshapes.wasm

   # Webサーバ上で確認を行う場合
   cargo build --target wasm32-unknown-unknown --release
   # 以下にwasmファイルが出力されます
   # basicshapes/target/wasm32-unknown-unknown/release/basicshapes.wasm
   ```
5. wasmファイルロード用のindex.htmlをプロジェクトルートディレクトリに作成します  
   ※あらかじめ、basicshapes.wasmを同ディレクトリにコピーしておきます

   ```html
   <html lang="ja">

   <head>
      <meta charset="utf-8">
      <title>basicshapes</title>
      <style>
         html,
         body,
         canvas {
            margin: 0px;
            padding: 0px;
            width: 100%;
            height: 100%;
            overflow: hidden;
            position: absolute;
            background: black;
            z-index: 0;
         }
      </style>
   </head>

   <body>
   <canvas id="glcanvas" tabindex='1'></canvas>
   <!-- Minified and statically hosted version of https://github.com/not-fl3/macroquad/blob/master/js/mq_js_bundle.js -->
   <script src="https://not-fl3.github.io/miniquad-samples/mq_js_bundle.js"></script>
   <script>load("basicshapes.wasm");</script> <!-- Your compiled wasm file -->
   </body>

   </html>
   ```
6. ローカル環境で確認するため、以下のコマンドを実行します  
   ※wasmファイルは「target/wasm32-unknown-unknown/debug/」配下のものを使うこと
   ```shell
   cargo install basic-http-server
   basic-http-server .
   ```

7. ブラウザから確認を行う
   デフォルト設定では **http://localhost:4000/** にアクセスすれば、出力結果が確認できます

# 最後に
macroquadのExampleがそれなりに充実してますので、今後使い方の解説記事を載せて行く予定です。

# 宣伝
Discord上でRustもくもく会用のギルドを作成しておりますので、興味があるかたは是非参加お願いします！  

[Rust-SAMURAI](https://disboard.org/ja/server/818441066716856332)