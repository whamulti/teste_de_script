#!/bin/bash

get_mysql_root_password() {
  
  print_banner
  printf "${WHITE} 💻 Insira uma senha para o usuario Deploy e para o Banco de Dados (Não utilizar caracteres especiais):${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " mysql_root_password
}

get_link_git() {
  
  print_banner
  printf "${WHITE} 💻 Insira o link do GITHUB do sistema:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " link_git
}

get_urls() {
  get_mysql_root_password
  get_link_git

}

inquiry_options() {
  
  print_banner
  printf "${WHITE} 💻 Bem vindo(a) ao Gerenciador Whamulti, Selecione abaixo a proxima ação!${GRAY_LIGHT}"
  printf "\n\n"
  printf "   [0] Instalar Whamulti\n"
  printf "\n"
  read -p "> " option

  case "${option}" in
    0) get_urls 
       ;;

    *) exit ;;
  esac
}


