#!/usr/bin/env bash

pbpaste > teste
elixir .script.exs teste flt
rm teste
osascript -e 'tell application "Terminal" to quit'
