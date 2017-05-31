#!/bin/bash
###############################################################
### Arch Linux Anywhere Install Script
### language.sh
###
### Copyright (C) 2017 Dylan Schacht
###
### By: Dylan Schacht (deadhead)
### Email: deadhead3492@gmail.com
### Webpage: http://arch-anywhere.org
###
### Any questions, comments, or bug reports may be sent to above
### email address. Enjoy, and keep on using Arch.
###
### License: GPL v2.0
###############################################################

language() {

	echo "$(date -u "+%F %H:%M") : Start arch-anywhere installer" > "$log"
	op_title="    Language Select    "
	ILANG=$(dialog --nocancel --menu "F123e Installer - Select your install language:" 20 60 10 \
		"English" "English" \
		"Bulgarian" "Български" \
		"Dutch" "Nederlands" \
		"French" "Français" \
		"German" "Deutsch" \
		"Greek" "Greek" \
		"Hungarian" "Magyar" \
		"Indonesian" "bahasa Indonesia" \
		"Italian" "Italiano" \
		"Latvian" "Latviešu" \
		"Lithuanian" "Lietuvių" \
		"Polish" "Polski" \
		"Portuguese" "Português" \
		"Portuguese-Brazilian" "Português do Brasil" \
		"Romanian" "Română" \
		"Russian" "Russian" \
		"Spanish" "Español" \
		"Swedish" "Svenska" 3>&1 1>&2 2>&3)

	case "$ILANG" in
		"English") export lang_file="$FI_DIR"/lang/f123e-installer-english.conf ;;
		"Bulgarian") export lang_file="$FI_DIR"/lang/f123e-installer-bulgarian.conf lib=bg bro=bg kdel=bg ;;
		"Dutch") export lang_file="$FI_DIR"/lang/f123e-installer-dutch.conf lib=nl bro=nl kdel=nl ;;
		"French") export lang_file="$FI_DIR"/lang/f123e-installer-french.conf lib=fr bro=fr kdel=fr ;;
		"German") export lang_file="$FI_DIR"/lang/f123e-installer-german.conf lib=de bro=de kdel=de ;;
		"Greek") export lang_file="$FI_DIR"/lang/f123e-installer-greek.conf lib=el bro=el kdel=el ;;
		"Hungarian") export lang_file="$FI_DIR"/lang/f123e-installer-hungarian.conf lib=hu bro=hu kdel=hu ;;
		"Indonesian") export lang_file="$FI_DIR"/lang/f123e-installer-indonesia.conf lib=id bro=id kdel=id ;;
		"Italian") export lang_file="$FI_DIR"/lang/f123e-installer-italian.conf lib=it bro=it kdel=it ;;
		"Latvian") export lang_file="$FI_DIR"/lang/f123e-installer-latvian.conf lib=lv bro=lv kdel=lv ;;
		"Lithuanian") export lang_file="$FI_DIR"/lang/f123e-installer-lithuanian.conf lib=lt bro=lt kdel=lt ;;
		"Polish") export lang_file="$FI_DIR"/lang/f123e-installer-polish.conf lib=pl bro=pl kdel=pl ;;
		"Portuguese") export lang_file="$FI_DIR"/lang/f123e-installer-portuguese.conf lib=pt bro=pt-pt kdel=pt ;;
		"Portuguese-Brazilian") export lang_file="$FI_DIR"/lang/f123e-installer-portuguese-br.conf lib=pt-BR bro=pt-br kdel=pt_br ;;
		"Romanian") export lang_file="$FI_DIR"/lang/f123e-installer-romanian.conf lib=ro bro=ro kdel=ro ;;
		"Russian") export lang_file="$FI_DIR"/lang/f123e-installer-russian.conf lib=ru bro=ru kdel=ru ;;
		"Spanish") export lang_file="$FI_DIR"/lang/f123e-installer-spanish.conf lib=es bro=es-es kdel=es ;;
		"Swedish") export lang_file="$FI_DIR"/lang/f123e-installer-swedish.conf lib=sv bro=sv-se kdel=sv ;;
	esac

}
