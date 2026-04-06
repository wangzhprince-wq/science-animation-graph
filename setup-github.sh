#!/bin/bash

# 科普动画知识图谱 - GitHub 部署脚本
# 使用方法：在创建 GitHub 仓库后运行此脚本

echo "=== 科普动画知识图谱 GitHub 部署 ==="
echo ""

# 检查是否在正确的目录
if [ ! -f "graph.json" ] || [ ! -f "index.html" ]; then
    echo "❌ 错误：请在项目根目录运行此脚本"
    exit 1
fi

# 询问 GitHub 仓库地址
read -p "请输入你的 GitHub 仓库地址 (格式: https://github.com/用户名/science-animation-graph.git): " REPO_URL

if [ -z "$REPO_URL" ]; then
    echo "❌ 错误：仓库地址不能为空"
    exit 1
fi

echo ""
echo "🔧 正在配置远程仓库..."
git remote add origin "$REPO_URL" 2>/dev/null

if [ $? -ne 0 ]; then
    echo "⚠️  远程仓库已存在，更新中..."
    git remote set-url origin "$REPO_URL"
fi

echo "✅ 远程仓库配置完成"
echo ""

echo "🚀 正在推送到 GitHub..."
git branch -M main
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 推送成功！"
    echo ""
    echo "接下来："
    echo "1. 访问 https://github.com/你的用户名/science-animation-graph"
    echo "2. 点击 Settings → Pages"
    echo "3. 在 'Source' 选择 'Deploy from a branch'"
    echo "4. 在 'Branch' 选择 'main' 和 '/ (root)'"
    echo "5. 点击 Save"
    echo "6. 等待几分钟，访问 https://你的用户名.github.io/science-animation-graph/"
else
    echo "❌ 推送失败，请检查："
    echo "   - 仓库地址是否正确"
    echo "   - 是否有写入权限"
    echo "   - 网络连接是否正常"
fi