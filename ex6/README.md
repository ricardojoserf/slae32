# Exercise 6

## Tests

```
```

## 6.1 Shellcode "TCP bind shell" 

Url: http://shell-storm.org/shellcode/files/shellcode-847.php

## 6.2 Shellcode "REVERSE shell"

Url: http://shell-storm.org/shellcode/files/shellcode-849.php

## 6.3 Shellcode "Add user r00t in /etc/passwd"

Url: http://shell-storm.org/shellcode/files/shellcode-211.php

## 6.4 Shellcode "chmod 0777 /etc/shadow"

Url: http://shell-storm.org/shellcode/files/shellcode-875.php


## Pre-steps
For files 3 and 4:
```
awk '//{print $4, $5 }' a
```

```
while read LINE; do echo ";$LINE"; done < 1.nasm
```
