#!/bin/bash
# Run this once from the highlights-tracker folder to create the repo and deploy.
# Requires: gh CLI (brew install gh) and being logged in (gh auth login)

set -e

REPO="brianeckmann-mp/highlights-tracker"

echo "→ Creating GitHub repo..."
gh repo create "$REPO" --public --source=. --remote=origin --push

echo "→ Enabling GitHub Pages (GitHub Actions source)..."
gh api repos/$REPO/pages \
  --method POST \
  -f build_type=workflow \
  -f source='{"branch":"main","path":"/"}' 2>/dev/null || \
gh api repos/$REPO/pages \
  --method PUT \
  -f build_type=workflow 2>/dev/null || true

echo ""
echo "✓ Done! Your site will be live in ~60s at:"
echo "  https://brianeckmann-mp.github.io/highlights-tracker"
echo ""
echo "If Pages isn't enabled automatically, go to:"
echo "  github.com/$REPO/settings/pages"
echo "  → Source: GitHub Actions → Save"
