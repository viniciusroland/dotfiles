#!/usr/bin/env bash

pbpaste > teste
elixir .script.exs teste sq
rm teste
osascript -e 'tell application "Terminal" to quit'
