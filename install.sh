# Обновить пакеты
apt update && apt dist-upgrade -y
apt install -y python3-pip python3-venv git ca-certificates

# Настроить консоль
echo "PS1='\[\033[01;32m\]\u\[\033[01;34m\]-\[\033[01;31m\]\h\[\033[00;34m\]{\[\033[01;34m\]\w\[\033[00;34m\]}\[\033[01;32m\]:\[\033[00m\]'" > ~/.bashrc

# Создать системного пользователя без домашней и без shell
id -u mytonctrl_bot >/dev/null 2>&1 || useradd --system --no-create-home --shell /usr/sbin/nologin mytonctrl_bot

# Подготовить каталоги
install -d -o mytonctrl_bot -g mytonctrl_bot /usr/src/mytonctrl_bot
install -d -o mytonctrl_bot -g mytonctrl_bot /var/mytonctrl_bot

# Клонировать репозиторий
git clone --recursive https://github.com/igroman787/mytonctrl_bot /usr/src/mytonctrl_bot
chown -R mytonctrl_bot:mytonctrl_bot /usr/src/mytonctrl_bot

# Создать виртуальное окружение и установить зависимости под пользователем
runuser -u mytonctrl_bot -- python3 -m venv /usr/src/mytonctrl_bot/env
runuser -u mytonctrl_bot -- /usr/src/mytonctrl_bot/env/bin/pip install --upgrade pip
runuser -u mytonctrl_bot -- /usr/src/mytonctrl_bot/env/bin/pip install -r /usr/src/mytonctrl_bot/requirements.txt

# Скопировать unit-файл
cp /usr/src/mytonctrl_bot/mytonctrl_bot.service /etc/systemd/system/mytonctrl_bot.service

# Перезагрузить systemd и включить сервис
systemctl daemon-reload
systemctl enable mytonctrl_bot