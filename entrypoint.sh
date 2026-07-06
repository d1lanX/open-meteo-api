#!/bin/sh
set -e

# One-off syncs (static terrain data, initial forecast data)
open-meteo sync copernicus_dem90 static
open-meteo sync ecmwf_ifs025 temperature_2m

# Start the API server
exec open-meteo serve
