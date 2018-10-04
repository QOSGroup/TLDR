
if you go code has like that
```
import git.qoschain.io/QOSGroup/qstars/xxx
```
you have to change all import to github.com
```
import github.com/QOSGroup/qstars/xxx
```
Please use follow command

```
sed -i -e 's/git.qoschain.io/github.com/g' `grep -rl 'git.qoschain.io'`
```
