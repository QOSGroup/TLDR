# Git

### 永久记住密码

> git config --global credential.helper store


### 撤销本地修改

> git reset --hard HEAD


### 切换到远程分支

> git checkout -b develop origin/develop


### 对你的commit操作设置关联的用户名

> git config --global user.name "[name]"

### 对你的commit操作设置关联的邮箱地址

> git config --global user.email "[email address]"


### 配置文件

> /etc/gitconfig  （参数: --system)
>
> ~/.gitconfig  （参数: --global)
>
> .git/config  （参数: --local)

### 删除远程分支 

> git push origin --delete <BranchName>

### 推送本地分支到远程不同名分支

> git config --global push.default upstream
> git branch -u <remote>/<branch>
> git branch -vv
> git push
