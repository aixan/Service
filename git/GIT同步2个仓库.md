## 1、首先创建2好2个仓库
    #假定创建好的两个仓库地址分别为：
    git@svnet.cn:Python.git
    git@github.com:aixan/Python.git

## 2、首先从其中一个仓库拉取代码
    git clone git@svnet.cn:Python.git
## 3、删除仓库origin
    git remote rm origin
## 4、关联2个远程仓库
```
    # 关联本地仓库
    git remote add svnet git@svnet.cn:Python.git
    git push gitee master

    # 关联github
    git remote add github git@github.com:aixan/Python.git
    git push github master
```
    # 注意此时如果遇到下述问题
    To https://github.com/CigoOS/cigoadmin_tp5.git
    ! [rejected]        master -> master (fetch first)
    error: failed to push some refs to 'git@github.com:aixan/Python.git'
    hint: Updates were rejected because the remote contains work that you do
    hint: not have locally. This is usually caused by another repository pushing
    hint: to the same ref. You may want to first integrate the remote changes
    hint: (e.g., 'git pull ...') before pushing again.
    hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```
    # 此时要先执行
    git pull github master --allow-unrelated-histories
```
## 5、全部合并成origin
在本地 git 仓库里找到这个文件 .git/config, 内容如下:  
```
    [core]
        repositoryformatversion = 0
        filemode = false
        bare = false
        logallrefupdates = true
        symlinks = false
        ignorecase = true
    [remote "origin"]
        url = git@svnet.cn:Python.git
        url = git@github.com:aixan/Python.git
        fetch = +refs/heads/*:refs/remotes/origin/*
    [branch "master"]
        remote = github
        merge = refs/heads/master
```