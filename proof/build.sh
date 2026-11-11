#!/usr/bin/env bash
# Builds the proof step's test site into _site/ (plan R3; restricted-networks design 6.9).
# With proof/page.html present: the 24 test pages, their stylesheet, and the files that measure
# how GitHub Pages serves addresses (RN 3.6). Without it: only a bare not-found page, which is
# how the cleanup takes the test pages down.
set -euo pipefail
rm -rf _site && mkdir -p _site
printf '<!doctype html><html lang="en"><title>404</title><p>404</p></html>\n' >_site/404.html
[[ -f proof/page.html ]] || exit 0
mkdir -p _site/t _site/assets _site/m/a _site/m/b _site/m/d _site/.well-known
cp proof/assets/* _site/assets/
for i in $(seq 1 24); do
  if ((i < 24)); then nav="Test page $i of 24 · <a href=\"/t/$((i + 1))\">Next page</a>"
  else nav="Test page 24 of 24, the last one · <a href=\"/t/1\">Start again</a>"; fi
  sed -e "s|__N__|$i|" -e "s|__NAV__|$nav|" proof/page.html >"_site/t/$i.html"
done
echo "file m/a.html" >_site/m/a.html
echo "directory m/a/" >_site/m/a/index.html
echo "file m/b/c.html" >_site/m/b/c.html
echo "directory m/d/" >_site/m/d/index.html
echo "dot directory" >_site/.well-known/proof.txt
