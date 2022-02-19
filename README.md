Домашнее задание к занятию "3.5. Файловые системы"  
  
2. Файлы, являющиеся жесткой ссылкой на один объект, не могут иметь разные права доступа и владельца.  
   По причине того, что в файловой системе они указывают на один и тот же объект inode.  
  
4.  
root@vagrant:~# fdisk /dev/sdb/  
  
Welcome to fdisk (util-linux 2.34).  
Changes will remain in memory only, until you decide to write them.  
Be careful before using the write command.  
  
  
Command (m for help): p  
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors  
Disk model: VBOX HARDDISK  
Units: sectors of 1 * 512 = 512 bytes  
Sector size (logical/physical): 512 bytes / 512 bytes  
I/O size (minimum/optimal): 512 bytes / 512 bytes  
Disklabel type: dos  
Disk identifier: 0xeb030542  
  
Device     Boot   Start     End Sectors  Size Id Type  
/dev/sdb1          2048 4196351 4194304    2G 83 Linux  
/dev/sdb2       4196352 5242879 1046528  511M 83 Linux  
  
5.  
root@vagrant:~# sfdisk -d /dev/sdb | sfdisk /dev/sdc  
Checking that no-one is using this disk right now ... OK  
  
Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors  
Disk model: VBOX HARDDISK  
Units: sectors of 1 * 512 = 512 bytes  
Sector size (logical/physical): 512 bytes / 512 bytes  
I/O size (minimum/optimal): 512 bytes / 512 bytes  
  
\>>> Script header accepted.  
\>>> Script header accepted.  
\>>> Script header accepted.  
\>>> Script header accepted.  
\>>> Created a new DOS disklabel with disk identifier 0xeb030542.  
/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.  
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.  
/dev/sdc3: Done.  
  
New situation:  
Disklabel type: dos  
Disk identifier: 0xeb030542  
  
Device     Boot   Start     End Sectors  Size Id Type  
/dev/sdc1          2048 4196351 4194304    2G 83 Linux  
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux  
  
The partition table has been altered.  
Calling ioctl() to re-read partition table.  
Syncing disks.  
  
6.  
root@vagrant:\~# mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1  
mdadm: Note: this array has metadata at the start and  
    may not be suitable as a boot device.  If you plan to  
    store '/boot' on this device please ensure that  
    your boot-loader understands md/v1.x metadata, or use  
    --metadata=0.90  
mdadm: size set to 2094080K  
Continue creating array? y  
mdadm: Defaulting to version 1.2 metadata  
mdadm: array /dev/md0 started.  
root@vagrant:\~# cat /proc/mdstat  
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]  
md0 : active raid1 sdc1[1] sdb1[0]  
      2094080 blocks super 1.2 [2/2] [UU]  
  
unused devices: <none>  
  
7.   
root@vagrant:\~# mdadm --create --verbose /dev/md1 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2  
mdadm: chunk size defaults to 512K  
mdadm: Defaulting to version 1.2 metadata  
mdadm: array /dev/md1 started.  
root@vagrant:\~# cat /proc/mdstat  
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]  
md1 : active raid0 sdc2[1] sdb2[0]  
      1042432 blocks super 1.2 512k chunks  
  
md0 : active raid1 sdc1[1] sdb1[0]  
      2094080 blocks super 1.2 [2/2] [UU]  
  
unused devices: <none>  
  
8.  
root@vagrant:\~# pvs  
  PV         VG        Fmt  Attr PSize    PFree  
  /dev/md0             lvm2 ---    <2.00g   <2.00g  
  /dev/md1             lvm2 ---  1018.00m 1018.00m  
  /dev/sda3  ubuntu-vg lvm2 a--   <63.00g  <31.50g  
    
9.  
root@vagrant:\~# vgcreate test_vg /dev/md0 /dev/md1  
  Volume group "test_vg" successfully created  
root@vagrant:\~# vgs  
  VG        #PV #LV #SN Attr   VSize   VFree  
  test_vg     2   0   0 wz--n-  <2.99g  <2.99g  
  ubuntu-vg   1   1   0 wz--n- <63.00g <31.50g  
    
10.  
  root@vagrant:\~# lvcreate -n 100mb -L 100M test_vg /dev/md1  
  Logical volume "100mb" created.  
  
11.  
root@vagrant:\~# mkfs.ext4 /dev/test_vg/100mb  
mke2fs 1.45.5 (07-Jan-2020)  
Creating filesystem with 25600 4k blocks and 25600 inodes  
  
Allocating group tables: done  
Writing inode tables: done  
Creating journal (1024 blocks): done  
Writing superblocks and filesystem accounting information: done  
  
12.  
root@vagrant:\~# mkdir /tmp/new  
root@vagrant:\~# mount /dev/test_vg/100mb /tmp/new  
  
13.  
root@vagrant:\~# cd /tmp/new/  
root@vagrant:/tmp/new# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz  
--2022-02-16 15:43:33--  https://mirror.yandex.ru/ubuntu/ls-lR.gz  
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183  
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.  
HTTP request sent, awaiting response... 200 OK  
Length: 22360951 (21M) [application/octet-stream]  
Saving to: '/tmp/new/test.gz'  
  
/tmp/new/test.gz              100%[=================================================>]  21.32M  12.1MB/s    in 1.8s  
  
2022-02-16 15:43:35 (12.1 MB/s) - '/tmp/new/test.gz' saved [22360951/22360951]  
  
14.  
root@vagrant:/tmp/new# lsblk  
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT  
loop0                       7:0    0 70.3M  1 loop  /snap/lxd/21029  
loop1                       7:1    0 55.4M  1 loop  /snap/core18/2128  
loop3                       7:3    0 55.5M  1 loop  /snap/core18/2284  
loop4                       7:4    0 43.6M  1 loop  /snap/snapd/14978  
loop5                       7:5    0 61.9M  1 loop  /snap/core20/1328  
loop6                       7:6    0 67.2M  1 loop  /snap/lxd/21835  
sda                         8:0    0   64G  0 disk  
├─sda1                      8:1    0    1M  0 part  
├─sda2                      8:2    0    1G  0 part  /boot  
└─sda3                      8:3    0   63G  0 part  
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm   /  
sdb                         8:16   0  2.5G  0 disk  
├─sdb1                      8:17   0    2G  0 part  
│ └─md0                     9:0    0    2G  0 raid1  
└─sdb2                      8:18   0  511M  0 part  
  └─md1                     9:1    0 1018M  0 raid0  
    └─test_vg-100mb       253:1    0  100M  0 lvm   /tmp/new  
sdc                         8:32   0  2.5G  0 disk  
├─sdc1                      8:33   0    2G  0 part  
│ └─md0                     9:0    0    2G  0 raid1  
└─sdc2                      8:34   0  511M  0 part  
  └─md1                     9:1    0 1018M  0 raid0  
    └─test_vg-100mb       253:1    0  100M  0 lvm   /tmp/new  
  
15.  
root@vagrant:/tmp/new# gzip -t /tmp/new/test.gz  
root@vagrant:/tmp/new# echo $?  
0  
  
16.  
root@vagrant:/tmp/new# pvmove /dev/md1  
  /dev/md1: Moved: 8.00%  
  /dev/md1: Moved: 100.00%  
root@vagrant:/tmp/new# lsblk  
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT  
loop0                       7:0    0 70.3M  1 loop  /snap/lxd/21029  
loop1                       7:1    0 55.4M  1 loop  /snap/core18/2128  
loop3                       7:3    0 55.5M  1 loop  /snap/core18/2284  
loop4                       7:4    0 43.6M  1 loop  /snap/snapd/14978  
loop5                       7:5    0 61.9M  1 loop  /snap/core20/1328  
loop6                       7:6    0 67.2M  1 loop  /snap/lxd/21835  
sda                         8:0    0   64G  0 disk  
├─sda1                      8:1    0    1M  0 part  
├─sda2                      8:2    0    1G  0 part  /boot  
└─sda3                      8:3    0   63G  0 part  
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm   /  
sdb                         8:16   0  2.5G  0 disk  
├─sdb1                      8:17   0    2G  0 part  
│ └─md0                     9:0    0    2G  0 raid1  
│   └─test_vg-100mb       253:1    0  100M  0 lvm   /tmp/new  
└─sdb2                      8:18   0  511M  0 part  
  └─md1                     9:1    0 1018M  0 raid0  
sdc                         8:32   0  2.5G  0 disk  
├─sdc1                      8:33   0    2G  0 part  
│ └─md0                     9:0    0    2G  0 raid1  
│   └─test_vg-100mb       253:1    0  100M  0 lvm   /tmp/new  
└─sdc2                      8:34   0  511M  0 part  
  └─md1                     9:1    0 1018M  0 raid0  
  
17.  
root@vagrant:/tmp/new# mdadm --fail /dev/md0 /dev/sdc1  
mdadm: set /dev/sdc1 faulty in /dev/md0  
  
18.  
[ 3059.095400] md/raid1:md0: Disk failure on sdc1, disabling device.  
               md/raid1:md0: Operation continuing on 1 devices.  
			     
19.  
root@vagrant:/tmp/new# gzip -t /tmp/new/test.gz  
root@vagrant:/tmp/new# echo $?  
0  
  
  
Домашнее задание к занятию "3.4. Операционные системы, лекция 2"
1.
/lib/systemd/system/node_exporter.service
[Unit]
Description=Node_exporter daemon

[Service]
EnvironmentFile=/etc/default/node_exporter
ExecStart=/opt/node_exporter/node_exporter $EXTRA_OPTS

[Install]
WantedBy=multi-user.target

/etc/default/node_exporter
EXTRA_OPTS=

sudo systemctl enable node_exporter
sudo systemctl start node_exporter
sudo systemctl stop node_exporter

сделал проброс порта 9100 чтобы смотреть на метрики

2.
node_cpu_seconds_total{cpu="0",mode="idle"}
node_cpu_seconds_total{cpu="1",mode="system"}
node_cpu_seconds_total{cpu="1",mode="user"}

node_memory_MemFree_bytes
node_memory_MemTotal_bytes

node_filesystem_avail_bytes{device="/dev/mapper/ubuntu--vg-ubuntu--lv",fstype="ext4",mountpoint="/"} 2.7262681088e+10

node_network_receive_bytes_total{device="eth0"} 
node_network_transmit_bytes_total{device="eth0"}
node_network_transmit_drop_total{device="eth0"}
node_network_speed_bytes{device="eth0"}

3. Установлено, проброшено, увидено.

4. думаю да
dmesg | grep virtual
[    0.002901] CPU MTRRs all blank - virtualized system.
[    0.105269] Booting paravirtualized kernel on KVM
[    4.588647] systemd[1]: Detected virtualization oracle.

5.
sudo sysctl -a | grep fs.nr_open
fs.nr_open = 1048576

fs.nr_open это верхний предел для параметра fs.file-max
определяет максимальное кол-во открытых файлов пользователем.

превысить не позволяет параметр Open files (ulimit -n) 

6.
unshare -f -p --mount-proc /bin/sleep 1h &
ps aux | grep sleep
nsenter --target 2167 --pid --mount

7.
это рекурсивная фукция, запускает в фоне две копии себя 
:() {
  : | : &
}
:

8.
механизм
fork rejected by pids controller in /user.slice/user-1000.slice/session-4.scope

настройки по умолчанию
/usr/lib/systemd/system/user-.slice.d/10-defaults.conf

По умолчанию максимальное количество задач, которое systemd разрешает для каждого пользователя, составляет 33% от «общесистемного максимума» ( sysctl kernel.threads-max)




Домашнее задание к занятию "3.3. Операционные системы, лекция 1"

1. сменит каталог вероятно вот этот - chdir("/tmp")
   stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0

2. openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
3. пробовал на процессе ping 127.0.0.1 > log &
   PID узнал ps ax | grep ping
   DESCRIPTOR узнал lsof -p PID
   echo '' > /proc/PID/fd/DESCRIPTOR
   
4. Все зомби-процессы после завершения работы родителя, переходят в управление процесса init, который их и убивает. 
зомби-процессы не осовобождают таблицу процессов.
 

5. PID    COMM               FD ERR PATH
1      systemd            12   0 /proc/634/cgroup
1      systemd            12   0 /proc/387/cgroup
1      systemd            12   0 /proc/603/cgroup
1218   vminfo              6   0 /var/run/utmp
619    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
619    dbus-daemon        20   0 /usr/share/dbus-1/system-services
619    dbus-daemon        -1   2 /lib/dbus-1/system-services
619    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
625    irqbalance          6   0 /proc/interrupts
625    irqbalance          6   0 /proc/stat
625    irqbalance          6   0 /proc/irq/20/smp_affinity

6.  использует системный вызов uname()       
   Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version,
       domainname}.
7. ; - разделяет команды
   && - логическое И
   использовать && если применять set -e не вижу смысла потому, что -e говорит о немедленном выходе, если команда завершается с не нулевым кодом.

8. 
-e прерывает выполнение исполнения при ошибке любой команды кроме последней в последовательности 
-x печать команд с аргументами по мере их выолнения 
-u считать неустановленные переменные ошибкой при подстановке
-o pipefail возвращает код возврата набора/последовательности команд, ненулевой при последней команды или 0 для успешного выполнения команд.
Вероятно для более быстрого выяснения где из-за чего возникают ошибки.

9.
S - бычный спящий процесс, который может быть прерван, ожидает какого-то события)
R - исполняется или ожидает исполнения;

доп символы это доп характеристики.


Домашнее задание к занятию "3.2. Работа в терминале, лекция 2"
1. Тип - встроенная команда оболочки.
2. grep <some_string> <some_file> -c
3. systemd(1)
4. ls 2> /dev/pts/1
5. cat <test.txt 1>test.2
6. Да получится, надо переключится на этот TTY.
7. Первая комада создает дескриптор 5 и перенаправлет в него stdout, вторая команда перенаправляет stdout от комады echo в дескриптор 5.
8. cat test 5>&2 2>&1 1>&5 | grep No
9. Переменные среды для текущего процесса.
   env
10. cmdline содержит полную командную строку для процесса, если этот процесс не является зомби.
    exe символическая ссылка, содержащая фактический путь к выполняемой команде.
11. SSE4.2
12. vagrant@vagrant:~$ ssh localhost 'tty'
    vagrant@localhost's password:
13. tee - читает стандартный ввод и пишет на стандартный вывод.
    sudo echo не работает потому, что перенаправлнеие рсушствляется оболочкой, запущенной без sudo	


Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"

1. Процессоры: 2
   ОЗУ: 1024 МБ
   ЖД: 64 ГБ

2. Необходимо изменить строки Vagranfile
config.vm.provider "virtualbox" do |v|
  v.memory = 1024
  v.cpus = 2
end

3. HISTSIZE
   строка 813 
   
   ignoreboth это сокращение для ignorespace и ignoredups
   
4. строка 1042 Brace Expansion
   используются для сокращения параметров команды
   rm -R img_{01,10,02,04}_2022.jpg

5. touch {1..10000}
   300000 Создать не получится "Argument list too long"  

6. Конструкция проверяет существует ли /tmp и являеься ли он папкой.

7. mkdir /tmp/new_path_directory
   export PATH=/tmp/new_path_directory:$PATH
   cp /bin/bash /tmp/new_path_directory/
   
8. at - одноразовая задача на заданное время
   batch - одноразовая задача выполняется когда загрузка процессора становится меньше 0,8.



Домашнее задание к занятию «2.4. Инструменты Git»

1. git show aefea
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.md

2. git show 85024d3
tag: v0.12.23

3. git show b8d720
родителей 2
56cd7859e 9ea88f22f

4. git log v0.12.24...v0.12.23
commit b14b74c4939dcab573326f4e3ee2a62e23e12f89
Author: Chris Griggs <cgriggs@hashicorp.com>
Date:   Tue Mar 10 08:59:20 2020 -0700

    [Website] vmc provider links

commit 3f235065b9347a758efadc92295b540ee0a5e26e
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Mar 19 10:39:31 2020 -0400

    Update CHANGELOG.md

commit 6ae64e247b332925b872447e9ce869657281c2bf
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Mar 19 10:20:10 2020 -0400

    registry: Fix panic when server is unreachable

    Non-HTTP errors previously resulted in a panic due to dereferencing the
    resp pointer while it was nil, as part of rendering the error message.
    This commit changes the error message formatting to cope with a nil
    response, and extends test coverage.

    Fixes #24384

commit 5c619ca1baf2e21a155fcdb4c264cc9e24a2a353
Author: Nick Fagerlund <nick.fagerlund@gmail.com>
Date:   Wed Mar 18 12:30:20 2020 -0700

    website: Remove links to the getting started guide's old location

    Since these links were in the soon-to-be-deprecated 0.11 language section, I
    think we can just remove them without needing to find an equivalent link.

commit 06275647e2b53d97d4f0a19a0fec11f6d69820b5
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Wed Mar 18 10:57:06 2020 -0400

    Update CHANGELOG.md

commit d5f9411f5108260320064349b757f55c09bc4b80
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Tue Mar 17 13:21:35 2020 -0400

    command: Fix bug when using terraform login on Windows

commit 4b6d06cc5dcb78af637bbb19c198faff37a066ed
Author: Pam Selle <pam@hashicorp.com>
Date:   Tue Mar 10 12:04:50 2020 -0400

    Update CHANGELOG.md

commit dd01a35078f040ca984cdd349f18d0b67e486c35
Author: Kristin Laemmert <mildwonkey@users.noreply.github.com>
Date:   Thu Mar 5 16:32:43 2020 -0500

    Update CHANGELOG.md

commit 225466bc3e5f35baa5d07197bbc079345b77525e
Author: tf-release-bot <terraform@hashicorp.com>
Date:   Thu Mar 5 21:12:06 2020 +0000

    Cleanup after v0.12.23 release
	
5. git log -S "func providerSource("
8c928e83589d90a031f811fae52a81be7153e82f	

6. находим файл где определена функция git grep -c "func globalPluginDirs("
   находим коммиты git log -L :globalPluginDirs:plugins.go
   78b12205587fe839f10d946ea3fdc06719decb05
   52dbf94834cb970b510f2fba853a5b49ad9b1a46
   41ab0aef7a0fe030e84018973a64135b11abcd70
   66ebff90cdfaa6938f26f908c7ebad8d547fea17
   8364383c359a6b738a436d1b7745ccdce178df47
   
7. git grep -c "func synchronizedWriters("
   команда вернула ничего, т.е. в файлах такой функции не нашлось.
  git log -S "synchronizedWriters" --oneline --pretty="%H of %an %ae" 

# devops-netology
Домашнее задание по лекции "Системы контроля версий"

В папке terraform будут игнорироваться:
1) всё содержимое папки .terraform;
2) файлы .tfstate, .tfstate.*;
3) файлы .crash.log, .crash.*.log;
4) файлы .tfvars
5) файлы override.tf, override.tf.json, *_override.tf, *_override.tf.json;
6) файлы .terraformrc, terraform.rc.