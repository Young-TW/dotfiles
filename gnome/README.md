# GNOME

GNOME 50 / libadwaita 1.9 桌面設定。

## GTK 純黑主題

CSS 在 `../home/.config/gtk-3.0/gtk.css` 與 `../home/.config/gtk-4.0/gtk.css`
(純黑 header bar + 主體背景)。這兩個檔案以 symlink 連到 `~/.config`,
**直接編輯即時生效**(重開 app)。新機器手動建立 symlink:

```bash
ln -sfn "$PWD/../home/.config/gtk-4.0/gtk.css" ~/.config/gtk-4.0/gtk.css
ln -sfn "$PWD/../home/.config/gtk-3.0/gtk.css" ~/.config/gtk-3.0/gtk.css
```

## dconf 設定快照

GNOME 主要設定存在 dconf(非文字檔),用腳本 dump 進此資料夾追蹤:

```bash
./backup.sh                       # 快照目前設定,然後 git commit
dconf load / < dconf/user.dconf   # 還原
```
