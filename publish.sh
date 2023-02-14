#!/bin/bash
dotnet publish -c Release

cd "$PUBLISH_DIR"/_framework && ls -fal && \
for f in ./*; do mv "$f" "`echo $f | sed -e 's/\.dll/.bin/g'`"; done && \
sed 's/\.dll"/.bin"/g' blazor.boot.json > blazor.boot.json.o && \
mv blazor.boot.json.o blazor.boot.json && \
brotli -f blazor.boot.json -o blazor.boot.json.br && \
gzip -9kf blazor.boot.json && \
ls -fal