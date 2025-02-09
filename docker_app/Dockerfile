# Node.jsダウンロード用ビルドステージ
FROM ruby:2.7.8 AS nodejs

# Node.jsダウンロード
# エラー対応でワークディレクトリを/tmpに設定
WORKDIR /tmp
RUN curl -LO https://nodejs.org/dist/v14.21.3/node-v14.21.3-linux-x64.tar.xz
RUN tar xJf node-v14.21.3-linux-x64.tar.xz
RUN mv node-v14.21.3-linux-x64 node

# Railsプロジェクトインストール
FROM ruby:2.7.8

# nodejsをインストールしたイメージからnode.jsをコピー
COPY --from=nodejs /tmp/node /opt/node
# ENVの表記を最新の書き方に変更
ENV PATH=/opt/node/bin:$PATH

# アプリケーション起動用のユーザを追加
RUN useradd -m -u 1000 rails
RUN mkdir /app && chown rails /app
USER rails

# yarnのインストール
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH=/home/rails/.yarn/bin:/home/rails/.config/yarn/global/node_modules/.bin:$PATH

# 2.7以上のrubyでrails newを実行するための設定
# 明示的にbundlerを最新にする
# RUN gem install bundler
# ruby2.7.8との互換性を考慮して2.4.22を指定
RUN gem install bundler -v 2.4.22

WORKDIR /app

# Dockerのビルドステップでキャッシュを使うためにGemfileだけ先にコピー
COPY --chown=rails Gemfile Gemfile.lock package.json yarn.lock /app/

RUN bundle install
RUN yarn install

COPY --chown=rails . /app

RUN bin/rails assets:precompile

VOLUME /app/public

# 実行時にコマンドを指定しなかった場合に実行されるコマンド
CMD ["bin/rails", "s", "-b", "0.0.0.0"]