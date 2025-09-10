# test-devops-EM
тз для Effective Mobile


как запустить:
# Делаем скрипт исполняемым
chmod +x /usr/local/bin/test_monitor.sh

# Перезагружаем конфиги systemd
systemctl daemon-reload

# Включаем и запускаем таймер
systemctl enable --now test-monitor.timer

Таким образом:
Скрипт запускается раз в минуту через systemd-таймер
Если процесс есть - POST на API
Если PID изменился - логируем рестарт
Если сервер мониторинга недоступен - логируем ошибку
Если процесс не запущен - выходим без действий
