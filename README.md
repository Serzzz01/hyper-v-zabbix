# hyper-v-zabbix
zabbix 6.0
Шаблон для мониторинга ВМ на сервере. Мониторинг включает общее количество ВМ, количество включенных ВМ, нагрузку RAM и CPU.
Для того чтобы шаблон заработал необходимо: 

1. Добавить скрипт discover_hyperv_vms в папку со скриптами. 

2. От добавить в файл zabbix_agent.conf строки:
    ### Количество всех ВМ
    UserParameter=hyperv.vm.count,powershell -NoProfile -Command "(Get-VM).Count"

    ### Количество работающих ВМ
    UserParameter=hyperv.vm.running,powershell -NoProfile -Command "(Get-VM | Where-Object {$_.State -eq 'Running'}).Count"

    ### LLD для ВМ
    UserParameter=hyperv.vms.discovery,powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent\scripts\discover_hyperv_vms.ps1"

    ### CPU ВМ
    UserParameter=hyperv.vm.cpu[*],powershell.exe -NoProfile -Command "$v=Measure-VM -Name '$1'; if ($v.ProcessorPercent -ne $null) { $v.ProcessorPercent } else { 0 }"

    ### RAM ВМ
    UserParameter=hyperv.vm.ram[*],powershell.exe -NoProfile -Command "(Measure-VM -Name '$1').MemoryAssigned / 1MB"

3. Если возникает ошибка о том, что измерение ресурсов не включено, необходимо запустить Enable-HyperV-Metering от имени администратора.
