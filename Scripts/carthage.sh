#!/bin/bash

#
# carthage.sh
# Usage example: ./carthage.sh build --platform iOS
#

set -euo pipefail

carthage "$@"