# build_env_android_part2

Android 14 离线构建环境分片包 - 第二部分

## 说明

本仓库是完整方案A（不含 NDK）的 17 个分片中的后 9 个分片（ai-aq）。

**必须与 [build_env_android-part1](https://github.com/kingopenr010077/build_env_android-part1) 配合使用**，才能还原完整环境。

## 文件列表

| 文件 | 大小 |
|---|---|
| scheme-a-full.tar.gz.ai | 95MB |
| scheme-a-full.tar.gz.aj | 95MB |
| scheme-a-full.tar.gz.ak | 95MB |
| scheme-a-full.tar.gz.al | 95MB |
| scheme-a-full.tar.gz.am | 95MB |
| scheme-a-full.tar.gz.an | 95MB |
| scheme-a-full.tar.gz.ao | 95MB |
| scheme-a-full.tar.gz.ap | 95MB |
| scheme-a-full.tar.gz.aq | 2.3MB |

## 完整还原方法

```bash
# 1. 克隆两部分
git clone https://github.com/kingopenr010077/build_env_android-part1.git
git clone https://github.com/kingopenr010077/build_env_android_part2.git

# 2. 合并所有分片
cat build_env_android-part1/scheme-a-full.tar.gz.* \
    build_env_android_part2/scheme-a-full.tar.gz.* \
    > scheme-a-full.tar.gz

# 3. 解压
tar xzf scheme-a-full.tar.gz
```

解压后得到 5 个组件压缩包：
- jdk-17.tar.gz - JDK 17
- android-sdk.tar.gz - Android SDK (API 34)
- gradle-8.4.tar.gz - Gradle 8.4 发行版
- maven-repo.tar.gz - Maven 依赖仓库
- gradle-cache.tar.gz - Gradle 构建缓存

## 组件安装

```bash
# 解压各组件到对应位置
cd scheme-a-full
tar xzf jdk-17.tar.gz -C /usr/lib/jvm/
tar xzf android-sdk.tar.gz -C /root/
tar xzf gradle-8.4.tar.gz -C /opt/
tar xzf maven-repo.tar.gz -C /your/project/maven-repo/
tar xzf gradle-cache.tar.gz -C ~/.gradle/

# 设置环境变量
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export ANDROID_HOME=/root/android-sdk
export GRADLE_HOME=/opt/gradle-8.4
export PATH=$JAVA_HOME/bin:$GRADLE_HOME/bin:$PATH
```

## 内容

- [build_env_android-part1](https://github.com/kingopenr010077/build_env_android-part1) - 第一部分（分片 aa-ah）
- [build_env_base](https://github.com/kingopenr010077/build_env_base) - 方案A的 LFS 版
- [build_env_ndk_part](https://github.com/kingopenr010077/build_env_ndk_part) - NDK 分片包