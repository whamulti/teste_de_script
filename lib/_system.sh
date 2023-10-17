#!/bin/bash
# 
# system management

#######################################
# creates user
# Arguments:
#   None
#######################################
system_create_user() {
  print_banner
  printf "${WHITE} 💻 Agora, vamos criar o usuário para a instancia...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 10

  sudo su - root <<EOF
  useradd -m -p $(openssl passwd -crypt ${mysql_root_password}) -s /bin/bash -G sudo deploy
  usermod -aG sudo deploy
EOF

  sleep 10
}

#######################################
# installs outros
# Arguments:
#   None
#######################################
system_outros_install() {
  print_banner
  printf "${WHITE} 💻 Instalando outros...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 10

  sudo su - root <<EOF
  apt install -y git
  sudo timedatectl set-timezone America/Sao_Paulo
  
EOF

  sleep 10
}

#######################################
# installs node
# Arguments:
#   None
#######################################
system_node_install() {
  print_banner
  printf "${WHITE} 💻 Instalando nodejs...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 10

  sudo su - root <<EOF
  curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  apt install -y nodejs
  
EOF

  sleep 10
}

#######################################
# updates system
# Arguments:
#   None
#######################################
system_update() {
  print_banner
  printf "${WHITE} 💻 Vamos atualizar o sistema Whaticket...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 10

  sudo su - root <<EOF
  apt -y update -y && apt upgrade -y
EOF

  sleep 10
}

#######################################
# installs nginx
# Arguments:
#   None
#######################################
system_nginx_install() {
  print_banner
  printf "${WHITE} 💻 Instalando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 10

  sudo su - root <<EOF
  apt install -y nginx
  rm /etc/nginx/sites-enabled/default
EOF

  sleep 10
}

#######################################
# setup for nginx.conf
# Arguments:
#   None
#######################################
system_nginx_conf() {
  print_banner
  printf "${WHITE} 💻 configurando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 10

sudo su - root << EOF

cat > /etc/nginx/conf.d/deploy.conf << 'END'
client_max_body_size 100M;
END

EOF

  sleep 10
}

#######################################
# restarts nginx
# Arguments:
#   None
#######################################
system_nginx_restart() {
  print_banner
  printf "${WHITE} 💻 reiniciando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 10

  sudo su - root <<EOF
  service nginx restart
EOF

  sleep 10
}

#######################################
# installs nginx
# Arguments:
#   None
#######################################
system_certbot_setup() {
  print_banner
  printf "${WHITE} 💻 Configurando certbot...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 10

  backend_domain=$(echo "${backend_url/https:\/\/}")
  frontend_domain=$(echo "${frontend_url/https:\/\/}")

  sudo su - root <<EOF
  certbot -m $deploy_email \
          --nginx \
          --agree-tos \
          --non-interactive \
          --domains $backend_domain,$frontend_domain

EOF

  sleep 10
}

#######################################
# installs certbot
# Arguments:
#   None
#######################################
system_certbot_install() {
  print_banner
  printf "${WHITE} 💻 Instalando certbot...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 10

  sudo su - root <<EOF
  snap install --classic certbot
  apt update
EOF

  sleep 10
}


#######################################
# installs pm2
# Arguments:
#   None
#######################################
system_pm2_install() {
  print_banner
  printf "${WHITE} 💻 Instalando pm2...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 10

  sudo su - root <<EOF
  npm install -g pm2

EOF

  sleep 10
}
