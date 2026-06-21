#!/bin/bash
# restore.sh - 还原 build_env_android 完整环境
# 使用前请确保已克隆 build_env_android-part1 和 build_env_android_part2

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK_DIR="${SCRIPT_DIR}/.."

echo "========================================"
echo " build_env_android 完整环境还原脚本"
echo "========================================"

# 检测两部分是否都存在
PART1_DIR="${WORK_DIR}/build_env_android-part1"
PART2_DIR="${SCRIPT_DIR}"

if [ ! -d "${PART1_DIR}" ]; then
    echo "[ERROR] 未找到 build_env_android-part1，请先克隆："
    echo "  git clone https://github.com/kingopenr010077/build_env_android-part1.git"
    exit 1
fi

echo "[1/5] 合并所有分片..."
cat "${PART1_DIR}/scheme-a-full.tar.gz."* \
    "${PART2_DIR}/scheme-a-full.tar.gz."* \
    > "${WORK_DIR}/scheme-a-full.tar.gz"

echo "[2/5] 解压合并后的压缩包..."
cd "${WORK_DIR}"
tar xzf scheme-a-full.tar.gz

echo "[3/5] 解压各组件..."
cd scheme-a-full

echo "  -> 解压 JDK 17..."
tar xzf jdk-17.tar.gz -C /usr/lib/jvm/

echo "  -> 解压 Android SDK..."
tar xzf android-sdk.tar.gz -C /root/

echo "  -> 解压 Gradle 8.4..."
tar xzf gradle-8.4.tar.gz -C /opt/

echo "  -> 解压 Maven 依赖仓库..."
tar xzf maven-repo.tar.gz -C "$(pwd)/maven-repo/"

echo "  -> 解压 Gradle 构建缓存..."
tar xzf gradle-cache.tar.gz -C ~/.gradle/

echo "[4/5] 设置环境变量..."
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export ANDROID_HOME=/root/android-sdk
export GRADLE_HOME=/opt/gradle-8.4
export PATH=${JAVA_HOME}/bin:${GRADLE_HOME}/bin:${PATH}

echo "[5/5] 验证安装..."
echo "  JAVA_HOME=${JAVA_HOME}"
echo "  ANDROID_HOME=${ANDROID_HOME}"
echo "  GRADLE_HOME=${GRADLE_HOME}"

if command -v java &> /dev/null; then
    echo "  Java: $(java -version 2>&1 | head -1)"
else
    echo "  [WARN] Java 未在 PATH 中找到"
fi

if command -v gradle &> /dev/null; then
    echo "  Gradle: $(gradle --version 2>&1 | grep 'Gradle ')"
else
    echo "  [WARN] Gradle 未在 PATH 中找到"
fi

echo "========================================"
echo " 还原完成！"
echo "========================================"
echo ""
echo "如需持久化环境变量，请将以下内容添加到 ~/.bashrc："
echo ""
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64'
echo 'export ANDROID_HOME=/root/android-sdk'
echo 'export GRADLE_HOME=/opt/gradle-8.4'
echo 'export PATH=$JAVA_HOME/bin:$GRADLE_HOME/bin:$PATH'