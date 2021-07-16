
# 提交修改，推到主分支
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
git add .
git commit -m "release 0.1.1"
git push -u origin main

echo '+++++++++++++++++++++++++++ commit successful ++++++++++++++++++++'

# 注意需要修改当前的版本号
echo '+++++++++++++++++++++++++++ pushing tags ++++++++++++++++++++'
git tag 0.1.1
git push --tags

echo '+++++++++++++++++++++++++++ pushing successful ++++++++++++++++++++'

# 检查库的语法完整性
echo '+++++++++++++++++++++++++++ spec lint ++++++++++++++++++++'
pod spec lint --allow-warnings

echo '+++++++++++++++++++++++++++ spec lint successful ++++++++++++++++++++'

# 提交仓库到本地和公共仓库
echo '+++++++++++++++++++++++++++ push spec ++++++++++++++++++++'
#pod repo add AppUpdate https://github.com/Bogon/CCSpec
#pod repo add AppUpdate https://github.com/CocoaPods/Specs
#pod repo push AppUpdate AppUpdate.podspec --sources='https://github.com/Bogon/CCSpec.git, https://github.com/CocoaPods/Specs.git' --allow-warnings
#pod repo add AppUpdate https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs
pod repo push AppUpdate AppUpdate.podspec --sources='https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git' --allow-warnings

echo '+++++++++++++++++++++++++++ push spec successful ++++++++++++++++++++'

