#!/usr/bin/env bash
# 把目前的 GNOME dconf 設定快照存進 repo,方便用 git 追蹤改動。
# GTK CSS 在 ../home/.config/gtk-*/,並以 symlink 連到 ~/.config 即時生效。
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 這是 public repo:剔除會洩漏最近路徑、且每次都變動的暫存區段。
# 用 paragraph 模式(空行分段),丟掉開頭符合下列前綴的整段。
strip_volatile() {
  awk 'BEGIN{RS="";FS="\n"}
       $1 !~ /^\[org\/gnome\/portal\/filechooser/ {print $0 "\n"}'
}

echo "→ dump dconf 全部設定(已過濾暫存路徑)"
dconf dump / | strip_volatile > "$ROOT/dconf/user.dconf"

echo "→ dump 介面/Shell 子樹(較好讀的 diff)"
dconf dump /org/gnome/desktop/interface/ > "$ROOT/dconf/interface.dconf"
dconf dump /org/gnome/shell/             > "$ROOT/dconf/shell.dconf"

echo "完成。記得 git add/commit。"
