# README


## 開発について


以下のコマンドをコンテナ内で実行する
```
bundle exec rails s -p 3000 -b '0.0.0.0'
```

### rspec

- テストケースを指定して実行する
-- typeをテストケースごとに指定しておく必要がある

```
// example
rspec ファイルパス -tag type:doing
```


### マイグレーション
- プロパティの追加

```
// example
rails g migration add_password_digest_to_user password_digest:string
```

## デプロイについて


