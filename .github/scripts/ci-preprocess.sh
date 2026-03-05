#!/bin/bash
# Pre-processing script for CI build
# Removes local development font configurations from .typ files

set -e

echo "Pre-processing .typ files for CI build..."

# Backup the post directory
TEMP_DIR=$(mktemp -d)
BACKUP_DIR="$TEMP_DIR/post_backup"

echo "Backing up post directory to $BACKUP_DIR"
cp -r ./post "$BACKUP_DIR"

# Function to restore original files on exit
cleanup() {
  echo "Restoring original files..."
  rm -rf ./post
  cp -r "$BACKUP_DIR" ./post
  rm -rf "$TEMP_DIR"
  echo "Cleanup complete"
}

# Register cleanup function to run on exit
trap cleanup EXIT

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
