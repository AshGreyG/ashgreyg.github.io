#!/bin/bash
# Pre-processing script for CI build
# Removes local development font configurations from .typ files

set -e

echo "Pre-processing .typ files for CI build..."

# Remove local font size configurations from all .typ files
echo "Removing local font configurations..."

# Find all .typ files in post directory and apply transformations
find ./post -name "*.typ" -type f -exec sed -i \
  -e 's/#show: set text(fill: color\.content, font: "C059", size: 12pt)/#show: set text(fill: color.content)/' \
  -e '/#show math\.equation\.where(block: true): set text(size: 14pt)/d' \
  {} \;

echo "Pre-processing complete. Files ready for CI build."

# Keep the script running (cleanup will happen on exit)
# The next CI step will use the modified files
