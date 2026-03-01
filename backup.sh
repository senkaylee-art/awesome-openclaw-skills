#!/bin/bash
# OpenClaw Memory Backup Script
# 用法: ./backup.sh [commit message]

BACKUP_DIR="$HOME/.openclaw/workspace/awesome-openclaw-skills/backup"
SOURCE_DIR="$HOME/.openclaw/workspace"
TODAY=$(date +%Y-%m-%d)

# 创建当日备份目录
mkdir -p "$BACKUP_DIR/$TODAY"

# 备份核心文件
for file in SOUL.md AGENTS.md USER.md IDENTITY.md TOOLS.md HEARTBEAT.md; do
    if [ -f "$SOURCE_DIR/$file" ]; then
        cp "$SOURCE_DIR/$file" "$BACKUP_DIR/$TODAY/"
    fi
done

# 备份 memory 目录
if [ -d "$SOURCE_DIR/memory" ]; then
    mkdir -p "$BACKUP_DIR/$TODAY/memory"
    cp -r "$SOURCE_DIR/memory"/* "$BACKUP_DIR/$TODAY/memory/" 2>/dev/null
fi

# Git 操作
cd "$BACKUP_DIR/.."
git add backup/
MSG="${1:-Backup $(date '+%Y-%m-%d %H:%M')}"
git commit -m "$MSG" || echo "No changes to commit"
git push origin main

echo "Backup completed: $TODAY"
