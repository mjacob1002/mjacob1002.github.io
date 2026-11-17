#!/usr/bin/env bash
# Build the CV from the CV repo (github.com/mjacob1002/CV) and install it as
# the PDF behind the site's "CV" button (assets/pdf/mkj_cv.pdf).
#
# Usage: bin/build_cv.sh [path-to-CV-repo]   (default: ../CV)
#
# The CV template was written against an older TeX Live (Overleaf). Two shims
# are injected at build time so it compiles unmodified on TeX Live 2024+:
#   1. FontAwesome is loaded from the repo's fonts/ dir by file name, and the
#      duplicate \FA definition (fontawesome package + class) is cleared.
#   2. \@finalstrut is restored to its pre-2024-06 definition; the newer one
#      collapses the bullet-list cell in \cventry so entries overlap.
set -euo pipefail

site_dir="$(cd "$(dirname "$0")/.." && pwd)"
cv_dir="$(cd "${1:-$site_dir/../CV}" && pwd)"
build_dir="$(mktemp -d)"
trap 'rm -rf "$build_dir"' EXIT

cat > "$build_dir/FontAwesome.fontspec" <<'EOF'
\defaultfontfeatures[FontAwesome]{Extension=.ttf,UprightFont=*}
EOF

cat > "$build_dir/cvfix.tex" <<'EOF'
\makeatletter
\AddToHook{package/fontawesome/after}{\let\FA\undefined}
\AddToHook{class/academic-cv/after}{%
  \def\@finalstrut#1{\unskip\ifhmode\nobreak\fi\vrule\@width\z@\@height\z@\@depth\dp#1}}
\makeatother
EOF

cd "$cv_dir"
for _ in 1 2; do
  TEXINPUTS="$build_dir:" TTFONTS="$cv_dir/fonts:" \
    xelatex -interaction=nonstopmode -halt-on-error \
    -jobname=cv -output-directory="$build_dir" \
    '\input{cvfix}\input{cv.tex}' > "$build_dir/build.log" \
    || { tail -40 "$build_dir/build.log"; exit 1; }
done

cp "$build_dir/cv.pdf" "$site_dir/assets/pdf/mkj_cv.pdf"
echo "Installed $site_dir/assets/pdf/mkj_cv.pdf (from $cv_dir @ $(git -C "$cv_dir" rev-parse --short HEAD))"
