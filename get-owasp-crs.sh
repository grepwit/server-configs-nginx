##
# Script to checkout to the latest branch selected
# or initially install OWASP ModSecurity CRS with nginx.
#    By: PSN <sony@psn.icu>
##

#!/bin/bash

CRS_BRANCH='v3.2/dev'
CRS_DIR='owasp-modsecurity-crs'
CRS_REMOTE='origin'

# Checkout to latest if dir exists or git clone owasp crs.
if [ -d $CRS_DIR ]; then
  echo "$CRS_DIR exists, checking out to $CRS_BRANCH..."
  cd "$CRS_DIR" || exit
  git fetch $CRS_REMOTE
  git checkout $CRS_REMOTE/$CRS_BRANCH
else
  echo "Cloning rules..."
  git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git -b $CRS_BRANCH
  cd "$CRS_DIR" || exit
fi

# Find if ModSecurity support is commented out & enable it
if grep -Fq "#  modsecurity" ../nginx.conf; then
  echo "Enabling ModSecurity in nginx.conf..."
  sed -i '/modsecurity/s/^  #//g' ../nginx.conf
fi

# Copy default conf if it does not exist
# Otherwise, generate a diff if changes are needed
if [ ! -f crs-setup.conf ]; then
  cp crs-setup.conf.example crs-setup.conf
  echo "Done. To configure, please read:"
  echo "  http://www.modsecurity.org/CRS/Documentation/install.html"
  echo ""
  echo "Initial config: $CRS_DIR/crs-setup.conf"
else
  echo "crs-setup.conf exists. Generating diff..."
  git diff --no-index crs-setup.conf crs-setup.conf.example > crs-setup.diff
  if [ -s crs-setup.diff ]; then
    echo ""
    echo "Changes stored in $CRS_DIR/crs-setup.diff. Check this file before applying with:"
    echo "    # NOTE: MUST be in $CRS_DIR"
    echo "    git apply crs-setup.diff"
  else
    echo "Everything is up to date."
    rm crs-setup.diff
  fi
fi
echo ""
echo "Restart nginx to apply any changes."
