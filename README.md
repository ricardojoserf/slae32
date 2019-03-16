<p align="center">
# Securitytube Linux Assembly Expert 32-bits
  <img src="http://videos.pentesteracademy.com.s3.amazonaws.com/videos/badges/low/SHELLCODING32.png" width="128" alt="Logo">
This course focuses on teaching the basics of 32-bit assembly language for the Intel Architecture (IA-32) family of processors on the Linux platform and applying it to Infosec. Once we are through with the basics, we will look at writing shellcode, encoders, decoders, crypters and other advanced low level applications.
</p>


---------------------------------------------------

## [Assignment #1](https://github.com/ricardojoserf/slae/tree/master/ex1)

- Create a Shell_Bind_TCP shellcode

	- Binds to a port

	- Execs Shell on incoming connection

- Port number should be easily configurable


---------------------------------------------------


## [Assignment #2](https://github.com/ricardojoserf/slae/tree/master/ex2)

- Create a Shell_Reverse_TCP shellcode

	- Reverse connects to configured IP and Port

	- Execs Shell on successful connection

- IP and Port number should be easily configurable


---------------------------------------------------


## [Assignment #3](https://github.com/ricardojoserf/slae/tree/master/ex3)

- Study about the Egg Hunter shellcode

- Create a working demo of the Egghunter

- Should be configurable for different payloads


---------------------------------------------------


## [Assignment #4](https://github.com/ricardojoserf/slae/tree/master/ex4)

- Create a custom encoding scheme like the "Insertion Encoder" we showed you

- PoC with using execve-stack as the shellcode to encode with your schema and execute


---------------------------------------------------

## [Assignment #5](https://github.com/ricardojoserf/slae/tree/master/ex5)

- Take up at leat 3 shellcode samples created using Msfvenom for linux/x86

- Use GDB/Ndisasm/Libemu to dissect the functionality of the shellcode

- Present your analysis

---------------------------------------------------


## [Assignment #6](https://github.com/ricardojoserf/slae/tree/master/ex6)

- Take up 3 shellcodes from Shell-Storm and create polymorphic versions of them to beat pattern matching

- The polymorphiv versions cannot be larger 150% of the existing shellcode

- Bonus points for making it shorter in length than original


---------------------------------------------------


## [Assignment #7](https://github.com/ricardojoserf/slae/tree/master/ex7)

- Create a custom crypter like the one shown in the "crypters" video

- Free to use any existing encryption schema

- Can use any programming language


---------------------------------------------------


## Note

This blog post has been created for completing the requirements of the SecurityTube Linux Assembly Expert certification: https://www.pentesteracademy.com/course?id=3

Student ID: SLAE - 1433