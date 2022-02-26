#!/usr/bin/env sh

# 發生錯誤時終止指令
set -e

# 打包
npm run build

# cd 到建構輸出的目錄下
cd dist

git init
git add -A
git commit -m 'deploy'

# 部署到 https://<USERNAME>.github.io/<REPO>
git push -f https://github.com/katesu/vue2_rest_countries.git master:gh-pages

cd -