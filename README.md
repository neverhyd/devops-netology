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
   export PATH=$PATH:/tmp/new_path_directory
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