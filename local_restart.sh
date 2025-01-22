fvm use 3.27.1 && fvm global 3.27.1 \
  && fvm flutter clean && fvm flutter pub get \
  && cd example \
  && fvm use 3.27.1 && fvm global 3.27.1 \
  && fvm flutter clean && fvm flutter pub get