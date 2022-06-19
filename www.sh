#------------------------------------------ Network traffic for Amazon Lightsail     --------------------------
# 用于按量计费的VPS流量达到限定值后关闭v2ray
# 依赖于vnstat流量统计，请先安装
# 默认设置流量500GB,每5分钟检测一次，建议留有余量
# 添加任务计划
# echo '@monthly root service v2ray start' >> /etc/crontab
# echo '*/5 * *   *   *   root bash /root/vnstat.sh' >>/etc/crontab
# 脚本上传至 /root 目录
#-----------------------------------------    by  https://t.me/likeuer      --------------------------------------
#!/bin/bash
v2ray_pid=$(pgrep -f /usr/bin/v2ray/v2ray)
vnstat_pid=$(pgrep -f /usr/sbin/vnstatd)
flow=$(vnstat -u && vnstat -m | grep $(date | awk '{printf $2}') | awk '{printf int($9)}')
total=$(vnstat -u && vnstat -m | grep $(date | awk '{printf $2}') | awk '{printf $9}')
time=$(date "+%Y-%m-%d %H:%M:%S")
a=$(vnstat -m | grep $(date | awk '{printf $2}') | awk '{printf $10}')
b=GiB
# 设置流量
max=100
if [ "$a" = "$b" ] && [ $v2ray_pid ] && [ $flow -ge $max ];then
service v2ray stop
echo -e  "<h1>aws 已消耗${flow}${a}  本月限额${max}${a}   ${time}  已停止服务 </h1>"   > /var/www/html/index.html
elif [ $vnstat_pid ] && [ $v2ray_pid ];then
echo -e  "<h1>aws 已消耗${total}${a}  ${time} 统计正常 </h1> <br>  "  > /var/www/html/index.html
fi




