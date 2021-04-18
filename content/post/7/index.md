---

title: "Rust+WebAssembly(WASM)の実装をGitHub Pagesに載せる方法"  
date: 2021-04-18T6:00:00+09:00  
draft: false  
tags: [Rust, WebAssembly]  
categories: [Rust]  

---

Rust+WebAssembly(wasm)の実装をGitHub Pagesに載せるのに苦労したのでやり方を解説します。

# 前提
1. `rustup`が使えること  
→ [導入方法](https://rustup.rs)
1. `Node.js`が使えること  
→ [導入方法](https://nodejs.org/ja/download/)
1. `wasm-pack`が使えること  
→ [導入方法](https://rustwasm.github.io/wasm-pack/installer/)
1. GitHub Pagesへのページ登録方法を知っていること

# 環境
- OS:Windows 10
- rust:1.50.0 (f04e7fab7 2021-02-04)
- toolchain:stable-x86_64-pc-windows-gnu
- rustup:1.23.1 (3df2264a9 2020-11-30)
- Node.js:6.14.4

# 準備
まずはこちらの記事から、「4.2. Hello,World!」まで進め、ローカル環境でRust+wasmのHello,Worldが表示できるところまで進めましょう。
https://rustwasm.github.io/docs/book/

また、有志の方が途中まで和訳したページもあるのでそちらを参照するのもよいかと思います。  
https://moshg.github.io/rustwasm-book-ja/

手っ取り早くHello,Worldまでいきたいという人のためにテンプレートを用意したので、こちらのリポジトリを`git clone`して頂いても大丈夫です。  
https://github.com/eda3/rust-wasm-template

上記のリポジトリを扱う場合についてコマンドベースで説明します。

# テンプレートリポジトリを利用する方法
1. 以下のコマンドを実行し、リポジトリをclone  
  `git clone https://github.com/eda3/rust-wasm-template.git`
1. cloneしたリポジトリに移動  
  `cd rust-wasm-template`
1. ブラウザ表示用のディレクトリに移動  
  `cd www`
1. wasm用にHello,Worldのソースをビルドする   
   `wasm-pack build`
1. wasm用のパッケージインストールを実行  
  `npm install`
1. ローカル確認用にサーバの始動を実行  
  `npm start`
1. https://localhost:8080/ を確認し、以下の文章が表示されることを確認  
  `Hello, rust-wasm-template!`  
   ※上記メッセージは`rust-wasm-template/src/lib.rs`で変更できます

# GitHub Pagesで出力結果を確認する方法
GitHub Pagesで結果を確認する場合、上記の方法では確認することが出来ません。wwwディレクトリをGitHubにpushした場合でも、以下のとおりHello,Worldは実行されません。  
リポジトリ：https://github.com/eda3/rust-wasm-template/tree/master/www  
GitHub Pages:https://eda3.github.io/rust-wasm-template/www/

GitHub Pagesで結果を確認する場合、wwwディレクトリで以下のコマンドを実行する必要があります。  
`npm run-script build`  

上記コマンド実行後、www/distの内容をGitHubにpushすればWebサーバ側でも確認することが出来ます。  
リポジトリ：https://github.com/eda3/rust-wasm-template/tree/master/www/dist  
GitHub Pages:https://eda3.github.io/rust-wasm-template/www/dist  