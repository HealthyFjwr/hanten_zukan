FROM ruby:3.3.4

# 必要パッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client \
  && npm install --global yarn

# 作業ディレクトリ
WORKDIR /app

# Gemfileをコピーしてbundle install
COPY Gemfile Gemfile.lock ./
RUN bundle install

# 残りのアプリケーションファイルをコピー
COPY . .

# ポート3000を公開
EXPOSE 3000

CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails db:migrate && bundle exec rails s -b '0.0.0.0'"]