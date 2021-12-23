

# 42-exam-trainer
A quick and easy program to train 42 exams.
Only exam 02 is supported for now.
## Install
This program uses `gcc` and `valgrind`, be sure  you got that covered.
Besides that, just clone the repository where you want.


## Usage
```bash
./exam-trainer.sh
```
Now don't say `LET'S GO !!` to anyone, and you should be good.

## Features
- Interactive, just like `examshell` (more or less)
	- `grademe` runs tests
	- `status` prints the time spent overall and on the current test
	- `help` prints all available commands
	- `quit` quits the exam
- Simple tests, just like during the exams
- Easily recompile and rerun tests outside the trainer
- Extensive error details (compilation errors, runtime, diffs, leaks)
- Checking leaks
- Easy to tweak
- Passive aggressive humor

## IMPORTANT
This program is currently a work in progress.
### Upcoming features
- Adding level 1 tests (`inter` and `union`)
- Adding tests subjects
- Exam mode, where only one test is chosen by level
- Allowing to skip a test
- Allowing to chose only one test to pass
- History
- Keeping high time score records

### Contributing
Do it !

### Licence
```
/*
 * ----------------------------------------------------------------------------
 * "THE SANDWICH-WARE LICENSE" (Revision 42):
 * <nsierra-@student.42.fr> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a sandwich in return. Rakjlou
 * ----------------------------------------------------------------------------
 */
```

## Screenshots
![a very nice feature](https://lh3.googleusercontent.com/s9fnPxoCaH_p9EoBFXgjBdduMSAea_H6e9ESLBJCeM0g8gQ7ZO9CInoHwUC-qcoipaVCGRH1FaZdWTIT0D68GqNznn626LsznrsM_OGN4jBWtC3kYQHmbQE5q8SxELSHOpVj5qQMfsFgzAP9uo0oSA0s2iRvldxnQ0K_XuqWta2v56eecxkRirITGR5uALJtOUVRPhBE7n0v6ngoyQCMvq7cWrleDezbd17qQAxoPGieM_sIjCbgO0xJBdpP4pzvlQCkjPS40e1i_YRjZrfKXpM1Fu1p6Xv1EyLD4DVfZO2hwemWwayShZK4huIs2FqHnui-AhrxZVTkA2G-f7lFQvLZjaL7RKzISD8k3g3WitBDCO5Ga1N2USUleJLEqnFdkeMSa8u9dUiFNMBIq6ol_140MEl-9mR2d3od-TlwVdPtsk4zW_jB-VfsQ5r3eOAQzWwGWSAUiYnDqVRtDQLlxMaZyUY2Yoyfxd1Nmqz_J4Lagl7hqIPkVr9YgLV4BQbJ0n50d7AT1FarS_pzMZpKw3t9EMoS_2ydGzLcIYNj8xOPhFiJ9InyFoC5FI8H7Q_HEyS_5DhGfJTNMbAuA2dEcVKXDvFDOV-1ZJTCRDYYG-XOLGLJtPbo1tuUT9lVJkMFfTmSzHGMFUq_UYb_LUBTpEFd_9M76XDtjsNdWj8spAJdxRaCPYU4w8wcGwBdUSiL4l8GT-v2xg9bmrlRfZa1iTI=w615-h437-no?authuser=0)
![an exquisite feature](https://lh3.googleusercontent.com/x3fnwTsXy8Y8oqAsGihn7oG3IezgH4O00C-12RnZnEhXRfUq-fRddxhkSCqrLuL-WI_Z6-4R-Xuofe4I_P0CDFN2EYpW6I9gYDUDDEDf72NQkTJWE0-GwA6lVAl2LPLsq7H08NwQRMoAR4D-MK4fmLS-jB-RWlFOGNS342zckGTJNE8Etz7rp-Sge6tqBQ5K6kja-Mik-J6rUKQROBLTYylgRhGh_CTiBZnhYQVNFH3Kag9eafK9AwO02cAnwLp0bbklul9FUmjKqz5R2tWk1bdYcws1MUMX8uaBU-DwlJ_-5HMJXf1hT9vAAnCHy1JsUyiTx_9gswnOBeSDN_IpayzrOE22SlOM35xZDli_AEIb7xf32mb5lPNCT3az-ZxbwvH5I0lhq6Y6XFnCpzibdXek49WoOxBY0Xy7o3PCvqsLywm6fQiXsbpkFS5kCRQUjCA4n4TGG30RB8BBh3gxF75nxNR9IHkiOK5D8FBLNmZ-5G-U5Xcuy9UAJcOqCrgZW7z4iOjI8FC2CszLfBjyAcgxlmDvALQcx5XCLEMNwNq8tx2ToRXmM21XW_otqutyZ4LSRLUrHMTvT-UVvG4PvGZc5E1U_9pNv9mbtEu0gOZwtt5PrJGehl0rt66CCNEFVVqHgo0-XzVQjsmk0fURFdkH-ZpnnZ6v9KkgDwMhsPJsu9ZeTNtLrJOu6CMxncqZRMBQOQPWolC20I5P1lzAPUU=w500-h200-no?authuser=0)
![just a feature](https://lh3.googleusercontent.com/WEKSoLLfZ1sbByQPGDrsxV4vReW52WnrxVNaSHqRHsXNk0Gw_b-X0fDkNyevvqI2pruDIkEBcFR6jE-n_z_3cApLv-n9ctkVLefONvAQS6E_U7WsM7JHCxT3KePQF4dwJRlJfuyWq3cU1XREeGNY2K4AHj6gOJ4nLFNW_qx2wVKm2RqYiDOKoYCQzZ1MXrKf5cbB_iwbAMu9yfsCqFpJYeQndr6sAMxvunjXLzevJx1AUOciUAK4J6tDDBJ0GCFAC5H6BBfeGBWZNrQpYJi2p6lGnbH1UZoCXEAYJqghqFEL0IQerw7YujnXxOcxKqvO6sIQFJDgSukt1II3GhqFvpd6j-lfub22i0peiGNh_JeybR5HGANTgaLs3RyFooXnP4hK3rEl1U45ll8dhwLeLLfwm95oaV_Pr9RvWfq2gVWxD1o6SGOmhXYHV6pchwcLdJln4Fuy27nvqtxzng-AQFEr0qT2zOsRdunEkkay-JU1LwZa-LB-di0Zxqic_n-kMV8LeucgekdOdfclIqrKZTcNB6ECmgHnGyuMfNG14eE5cSBx4O0UuzV66YW-UVndyglI-Ekf1Q0XqYkU6eTtm1CMLn9YvSyHav4v92oWaMobpheYYG1xfrdiQJzjlEOTXCpxT6uL-UDS7UhRys-IP5lFKN0g4-QHL_JEz-iyeaM_3o6_cH8vmsbKylzAXmX52h-o933y5c1dsVlSRfdUCzE=w381-h344-no?authuser=0)
