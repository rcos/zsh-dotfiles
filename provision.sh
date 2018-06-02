# Install VirtualBox + Vagrant
sudo echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" >> /etc/apt/sources.list

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y virtualbox-5.1
sudo apt-get install -y vagrant

# # # #

# Install Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text -y

# # # #
# Paper (nice icons)

# adds daily build repo for icons
sudo add-apt-repository ppa:snwh/pulp
# update repository info
sudo apt-get update
# install icon theme
sudo apt-get install paper-icon-theme -y
# install cursor theme
sudo apt-get install paper-cursor-theme -y
# install gtk theme
sudo apt-get install paper-gtk-theme -y

# # # #

# ThoughtBot RCM
wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb http://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update
sudo apt-get install rcm

# TMUX
sudo apt-get install tmux

# # # #

# F.lux
sudo add-apt-repository ppa:nathan-renniewaldock/flux
sudo apt-get update
sudo apt-get install -y fluxgui

# # # #

# Lenovo Figerprint Scanner
# sudo add-apt-repository ppa:fingerprint/fingerprint-gui
# sudo apt-get update
# sudo apt-get install libbsapi policykit-1-fingerprint-gui fingerprint-gui

# # # #

# Enpass
# https://www.enpass.io/kb/how-to-install-on-linux/
sudo -i
echo "deb http://repo.sinew.in/ stable main" > \
  /etc/apt/sources.list.d/enpass.list

wget -O - https://dl.sinew.in/keys/enpass-linux.key | apt-key add -
sudo apt-get update
sudo apt-get install -y enpass

# # # #

# Install Postman
wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
sudo tar -xzf postman.tar.gz -C /opt
rm postman.tar.gz

# PUT THIS IN ~/.local/share/applications/postman.desktop
	# [Desktop Entry]
	# Type=Application
	# Version=1.0
	# Name=Postman
	# Comment=Supercharge your API workflow
	# Icon=/opt/Postman/resources/app/assets/icon.png
	# Exec="/opt/Postman/Postman"

# # # #

# Install dconf-editor
sudo apt-get install dconf-editor dconf-cli -y

# # # #
# Install rbenv

# Install requirements
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

# Installs rbenv
cd ~
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

# Re-installs ruby 2.3
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.3.1
rbenv global 2.3.1
ruby -v

# PROFIT???
rbenv rehash

# # # #

# Install RVM
echo "\nInstalling RVM..."
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm


echo "\nAdding 'aeksco' user to rvm group..."
sudo usermod -aG rvm aeksco


# # # #

# Remove LibreOffice
# Install ZSH
# Install Tmux
# Install Docker

# # # # #

echo "\nUpdating existing packages (sudo apt-get update)..."
sudo apt-get update

echo "\nInstalling Git and ls Unzip..."
sudo apt-get install -y git unzip zsh

# # # # #

echo "\nInstalling Docker..."
curl -sSL https://get.docker.com/ | sh

echo "\nAdding 'aeksco' user to docker group..."
sudo usermod -aG docker aeksco

# # # # #

# echo "\nInstalling Docker Compose..."
sudo curl -o /usr/local/bin/docker-compose -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m`
sudo chmod +x /usr/local/bin/docker-compose

# # # # #

# echo "\nInstalling Node.js..."
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

# echo "\Configuring node..."
mkdir ~/npm-global
sudo chown -R aeksco:aeksco ~/npm-global
npm config set prefix '~/npm-global'
echo "export PATH=~/npm-global/bin:$PATH" >> ~/.profile
source ~/.profile

# echo "\nInstalling global NPM CLI tools..."
npm install -g gulp nodemon

# # # # #
