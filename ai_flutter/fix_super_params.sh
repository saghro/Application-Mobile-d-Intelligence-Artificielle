#!/bin/bash
find lib -name "*.dart" -exec sed -i '' 's/{super\.key}/{Key? key}) : super(key: key/g' {} \;
