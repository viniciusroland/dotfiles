#!/usr/bin/env bash

pbpaste > teste
elixir .script.exs teste flt sum
rm teste
osascript -e 'tell application "Terminal" to quit'
