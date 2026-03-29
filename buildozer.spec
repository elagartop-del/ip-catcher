[app]

title = IP Catcher
package.name = ipcatcher
package.domain = com.tool

source.dir = .
source.include_exts = py
version = 1.0

requirements = python3,kivy,requests

orientation = portrait

android.permissions = INTERNET,ACCESS_NETWORK_STATE

[buildozer]

log_level = 2
build_dir = ./.buildozer
bin_dir = ./bin
