## ubuntu 10.04 longterm release

Install from USB

Following the instructions to format MBR led to problem as noticed here: http://ubuntuforums.org/showthread.php?t=1582292&page=2

Solution:

* Input usb drive.
* Reboot system.
* Log into Ubuntu.

```bash
sudo apt-get install grub-pc

grub-install -v # (make sure it's a Grub2 version, which should be later than 0.97)
```

my boot disk (which for me is my only disk) is on /dev/sda2. To make this disk bootable:

```bash
sudo grub-install /dev/sda
```

reboot, and it worked.
