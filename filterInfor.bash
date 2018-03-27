#!/bin/bash

################################################################################
#Script for documentation of operating system Linux or UNIX
#@author:	Ailson Ramon
#@date: 	20/03/2018
#@version: 	1.1 (20/03/2018)
#@description:
#The script builds 3 txt extesions files with information collected from the server
#For correct operation recommend exec with root user
################################################################################


##############  GLOBAL VARIABLE  ###############################################
#Nome do arquivo
DOCSO="doc-$(uname -n)-system.txt" #RECEBE AS INFORMACOES DE SISTEMA
DOCREDE="doc-$(uname -n)-redes.txt" #RECEBE AS INFORMACOES DE REDE
DOCSERV="doc-$(uname -n)-service.txt" #RECEBE AS INFORMACOES DE SERVICOS
DOCPORTSERVICE="doc-$(uname -n)-PORTSERVICE.txt" #RECEBE AS INFORMACOES DAS PORTAS
DOCQIP="doc-$(uname -n)-VitalQIP.txt" 			#RECEBE AS INFORMACOES DO QIP
SO="$(uname -s)"			      # Pega o Kernel name
LINUX="Linux"
SUN="SunOS" 
#################### AUX FUNCTION  ############################################


# touchFile
# @date	    - 20/03/2018
# @author	- Ailson Ramon
# @version	- 1.0 (20/03/2018)
#	 Versao inicial
# @description
#	build 3 txt files
# @params
#	 void
# @return
#	 Void
function touchFile()
{	
	touch $(pwd)/"$DOCSO" #create system file
	touch $(pwd)/ "$DOCREDE" #create network file
	touch $(pwd)/"$DOCSERV" #create Operating System file
	touch $(pwd)/"$DOCPORTSERVICE"
	touch $(pwd)/"$DOCQIP"

	chmod 755 $(pwd)/"$DOCREDE" # permission rwxr r-x r-x
	chmod 755 $(pwd)/"$DOCSO"	# permission rwxr r-x r-x
	chmod 755 $(pwd)/"$DOCSERV"	# permission rwxr r-x r-x
	chmod 755 $(pwd)/"$DOCPORTSERVICE" # permission rwxr r-x r-x
	chmod 755 $(pwd)/"$DOCQIP"
	echo "Arquivos de documentacao criados"
}

#run the function
touchFile

clear
echo "Criando arquivo de documentacao..."
sleep 1
echo -e "\nCriando arquivo do SISTEMA"

echo "DOCUMENTACAO DE SISTEMA DO SERVIDOR- $(uname -n)" > $DOCSO

echo -e "=== INFORMACAO DE DATA ===\n" >> $DOCSO
echo -e "DATA: $(date)\nComandos utilizados: date" >> $DOCSO
echo -e "UPTIME:\nComandos utilizados:uptime\n$(uptime)\n" >> $DOCSO



echo " -------------------------------" >> $DOCSO
echo "====INFORMACOES DE SISTEMA====" >> $DOCSO
echo -e " -------------------------------\n" >> $DOCSO

# checkDistr
# @date	    - 20/03/2018
# @author	- Ailson Ramon
# @version	- 1.0 (20/03/2018)
#	 Versao inicial
# @description
#	Verifica qual é o sistema utilizado e coloca as informoes coletadas no documento
# @params
#	 void
# @return
#	 Void

function checkDistr()
{
	if [ $SO = $LINUX ] ; then
		echo -e "Distribuicao:\n Comandos utilizados: cat /etc/*-release\n $(cat /etc/*-release)\n" >> $DOCSO
	elif [ $SO = $SUN ] ; then
		echo -e "Distribuicao:\n Comando utilizado: cat /etc/release \n $(cat /etc/release)\n" >> $DOCSO
	fi
}
checkDistr

echo "Kernel-versio: $(uname -v)" >> $DOCSO
echo -e "Kernel-release: $(uname -r)\nComandos utilizados: uname -r -v \n" >> $DOCSO


echo "-------------------------------" >> $DOCSO
echo "=== INFORMACAO DE PARTICAO ===" >> $DOCSO
echo -e "-------------------------------\n\n" >> $DOCSO

# diskinfo
# @date	    - 20/03/2018
# @author	- Ailson Ramon
# @version	- 1.0 (20/03/2018)
#	 Versao inicial
# @description
#	Pega as informacoes de particoes dependendo do SO
# @params
#	 void
# @return
#	 Void
function diskinfo
{
	if [ $SO = $LINUX ] ; then
		echo -e "\nPARTICOES:\nComandos utilizados: fdisk -l \n $(fdisk -l)\n" >> $DOCSO
		echo -e "\n PARTICOES COM iNodes:\nComandos utilizados: df -i\n $(df -i)\n" >> $DOCSO
		echo -e "\nUSO DE PARTICOES:\nComandos utilizados: df -kh\n:$(df -kh)\n" >> $DOCSO
		echo -e "\nPARTICOES MONTADAS:\nComandos utilizados: mount\n $(mount)\n" >> $DOCSO
	elif [ $SO = $SUN ] ; then
		echo -e "\nPARTICOES:\nComandos utilizados: echo | format \n $(echo | format)\n" >> $DOCSO
		echo -e "\n PARTICOES COM iNodes:\nComandos utilizados: df -F ufs -o i\n $(df -F ufs -o i)\n" >> $DOCSO
		echo -e "\nUSO DE PARTICOES:\nComandos utilizados: df -kh\n:$(df -kh)\n" >> $DOCSO
		echo -e "\nPARTICOES MONTADAS:\nComandos utilizados: mount\n $(mount)\n" >> $DOCSO

	fi
}

#run the function
diskinfo



echo "------------------------------" >> $DOCSO
echo "=== INFORMACAO DE HARDWARE===" >> $DOCSO
echo "------------------------------" >> $DOCSO

# hardinfo
# @date	    - 20/03/2018
# @author	- Ailson Ramon
# @version	- 1.0 (20/03/2018)
#	 Versao inicial
# @description
#	Pega as informacoes de hardware dependendo do SO
# @params
#	 void
# @return
#	 Void

function hardinfo
{
	if [ $SO = $LINUX ] ; then
		echo -e "\nINFORMACAO DO PROCESSADOR:\nComando utilizado: cat /proc/cpuinfo\n$(cat /proc/cpuinfo)\n" >> $DOCSO
		echo -e "INFORMACAO DE MEMORIA:\nComando utilizado: cat /proc/memoinfo\n$(cat /proc/meminfo)\n" >> $DOCSO
		echo -e "INFORMACAO DE SWAP:\n $(swapon -s)\nComando utilizado: swapon -s\n" >> $DOCSO
		echo -e "\nINFORMACAO DA TABELA DE SISTEMA:\nComando utilizado: cat/etc/fstab\n $(cat /etc/fstab)\n">>$DOCSO
	elif [ $SO = $SUN ] ; then
		echo -e "\nINFORMACAO DO PROCESSADOR:\nComando utilizado: psrinfo\n$(psrinfo)\n" >> $DOCSO
		echo -e "INFORMACAO DE SWAP:\nComando utilizado: swapon -s\n\n $(swap -s)\n" >> $DOCSO
		echo -e "INFORMACAO DE MEMORIA:\nComando utilizado: prtconf | grep Memory && vmstat\n$(prtconf | grep Memory && vmstat)\n " >> $DOCSO
		echo -e "\nINFORMACAO DA TABELA DE SISTEMA:\nComando utilizado: cat/etc/vfstab\n $(cat /etc/vfstab)\n">>$DOCSO
		echo -e "\nSolaris Operating Environment:\nComado utilizado: isainfo -v $(isainfo -v)\n" >> $DOCSO
	fi

}

hardinfo

echo "DOCUMENTACAO DO SISTEMA CRIADA COM SUCESSO"
#termino da doc de sistema aguardar 2 sec
sleep 2




echo "CRIANDO DOCUMENTACAO DE SERVIÇOS" 
echo "DOCUMENTACAO DE SERVIÇOS DO SERVIDOR - $(uname -n)" > $DOCSERV

echo "----------------------------------" >> $DOCSERV
echo "==== INFORMACOES DE SERVIÇOS =====" >> $DOCSERV
echo "----------------------------------" >> $DOCSERV

echo -e "INFORMACOES DO CRON:\nComando utilizado: crontab -l\n $(crontab -l)\n\n	" >> $DOCSERV

echo "====================================" >> $DOCSERV
echo -e "--- INFORMACOES DE INICIALIZACAO---\n" >> $DOCSERV

# checkInit
# @date	    - 20/03/2018
# @author	- Ailson Ramon
# @version	- 1.0 (20/03/2018)
#	 Versao inicial
# @description
#	Pega as informacoes de inicializacao dependendo do SO
# @params
#	 void
# @return
#	 Void
function checkInit()
{
	if [ $SO = $LINUX ] ; then
		echo -e "Comandos utilizado: chkconfig --list\n\n $(chkconfig --list)\n" >> $DOCSERV
		echo -e "\n--- INFORMACOES DE PROGRAMAS INSTALADOS---\n">> $DOCSERV
		echo -e "\n Comando utilizado: yum list installed\n\n $(yum list installed)\n" >>$DOCSERV
		
		echo -e "\n--- INFORCAMOES DE GRUPOS INSTALADOS--- \n" >> $DOCSERV
		echo -e "\nComando utilizado: yum grouplist\n\n $(yum grouplist)">> $DOCSERV
		
		echo -e "\n\n-----INFORMACOES DOS SERVICOS-----\n" >> $DOCSERV
		echo -e "\nComando utilizado: service --status--all\n\n$(service --status-all)" >> $DOCSERV

	elif [ $SO = $SUN ] ; then
		echo -e "Comandos utilizado: svcs -a\n\n $(svcs -a)\n" >> $DOCSERV
		echo -e "\n--- INFORMACOES DE PROGRAMAS INSTALADOS---\n">> $DOCSERV
		echo -e "-----INFORMACOES DOS SERVICOS-----\n" >> $DOCSERV
		echo -e "\n Comando utilizado: pkginfo \n\n $(pkginfo)\n\n" >>$DOCSERV
		
		echo -e "\n--- INFORCAMOES DE GRUPOS INSTALADOS--- \n" >> $DOCSERV
		echo -e "\nComando utilizado: pkg list -as '*group/system/solaris*'\n\n $(pkg list -as '*group/system/solaris*')\n">> $DOCSERV
	fi
}
checkInit


echo -e "----INFORMACOES DO NTP-----\n" >> $DOCSERV
# checkNTP
# @date	    - 20/03/2018
# @author	- Ailson Ramon
# @version	- 1.0 (20/03/2018)
#	 Versao inicial
# @description
#	Pega as informacoes do servidor de tempo dependendo do SO
# @params
#	 void
# @return
#	 Void

function checkNTP
{
	if [ $SO = $LINUX -a -e "/etc/ntp.conf" ] ; then #verifica a existencia da pasta e o SO
		echo -e "\nComando utilizado: cat /etc/ntp.conf\n $(cat /etc/ntp.conf)" >> $DOCSERV
		echo -e "\nComando utilizado: ntpq -p\n\n$(ntpq -p)" >> $DOCSERV

	elif [ $SO = $SUN -a -e "/etc/inet/ntp.conf" ]; then
		echo -e "\nComando utilizado: cat /etc/inet/ntp.conf\n $(cat /etc/inet/ntp.conf)" >> $DOCSERV
		echo -e "\nComando utilizado: ntpq -p\n\n$(ntpq -p)" >> $DOCSERV
	else
		echo -e "ntp.conf não foi encontrado nos caminhos\n Linux:\n /etc/ntp.conf\n SunOs:\n /etc/inet/ntp.conf"
		sleep 4
	fi
}
checkNTP


echo -e "\n----INFORMACOES DO SELINUX----\n" >> $DOCSERV

# checkSE
# @date	    - 20/03/2018
# @author	- Ailson Ramon
# @version	- 1.0 (20/03/2018)
#	 Versao inicial
# @description
#	Pega as informacoes de segurança dependendo do SO
# @params
#	 void
# @return
#	 Void
function checkSE
{
	if [ $SO = $LINUX ] ; then
	 echo -e "\nComando utilizado: cat /etc/selinux/config && sestatus \n\n $(cat /etc/selinux/config && sestatus)\n " >> $DOCSERV
	elif [ $SO = $SUN ] ; then
	 echo -e "\nComando utilizado:cat /etc/security/policy.conf\n\n $(cat /etc/security/policy.conf)\n\n" >> $DOCSERV
	 echo -e "\nComando utilizado: cat /etc/security/device_policy\n\n $(cat /etc/security/device_policy)\n\n" >> $DOCSERV
	fi
}
checkSE



echo "DOCUMENTACAO DE SERVIÇOS CRIADO COM SUCESSO"
sleep 4

echo "CRIANDO DOCUMENTACAO DE REDE..."
sleep 2

echo "DOCUMENTACAO DE REDE DO SERVIDOR- $(uname -n)" > $DOCREDE
# checkPING
# @date	    - 20/03/2018
# @author	- Ailson Ramon
# @version	- 1.0 (20/03/2018)
#	 Versao inicial
# @description
#	Pega as informacoes de pacotes dependendo do SO
# @params
#	 void
# @return
#	 Void
function checkPING
{
	if [ $SO = $LINUX ] ; then
		echo -e "\n TESTANDO PACOTES\nComando utilizado: ping -w 4 8.8.8.8\n\n$(ping -w 4 8.8.8.8)\n" >> $DOCREDE
	elif [ $SO = $SUN ] ; then
		echo -e "\n TESTADO PACOTES\nComando utilizado: ping 8.8.8.8\n $(ping 8.8.8.8)\n" >> $DOCREDE
	fi


}
checkPING


echo -e "\nINFORMACOES DAS INTERFACES\n" >> $DOCREDE
# checkINTERFACES
# @date	    - 20/03/2018
# @author	- Ailson Ramon
# @version	- 1.0 (20/03/2018)
#	 Versao inicial
# @description
#	Pega as informacoes de Interfaces dependendo do SO
# @params
#	 void
# @return
#	 Void
function checkINTERFACES
{
	if [ $SO = $LINUX ] ; then
		if [ ifconfig ] ; then
			echo -e "\n Comando utilizado: -ifconfig -a\n\n$(ifconfig -a)" >> $DOCREDE
		else
			echo -e "\n Comando utilizado: ip add\n\n$(ip add)" >> $DOCREDE
		fi
	elif [ $SO = $SUN ] ; then
		echo -e "\nComando utilizado: ipadm && dladm\n\n $(ipadm)\n\n $(dladm)" >> $DOCREDE
	fi

}

checkINTERFACES

echo -e "\n--- INFORMACOES DE REDE ---\n " >> $DOCREDE
# checkNETWORK
# @date	    - 20/03/2018
# @author	- Ailson Ramon
# @version	- 1.0 (20/03/2018)
#	 Versao inicial
# @description
#	Pega as informacoes de REDE dependendo do SO
# @params
#	 void
# @return
#	 Void
function checkNETWORK
{
	if [ $SO = $LINUX ] ; then
		echo -e "\nComando utilizado: cat /etc/sysconfig/network\n\n$(cat /etc/sysconfig/network) \n " >> $DOCREDE
		echo -e "--- INFORMACOES DE DNS ---\n " >> $DOCREDE
		echo -e "\nComando utilizado: cat /etc/resolv.conf\n\n$(cat /etc/resolv.conf)\n" >> $DOCREDE
		
		echo -e "--- INFORMACOES DE NOME E DOMINIO DA MAQUINA---\n" >> $DOCREDE
		echo -e "\nComando utilizado: cat /etc/hosts\n\n $(cat /etc/hosts)\n" >> $DOCREDE
		
		echo -e "\n -- IFORMACOES DE ROTAS --- " >> $DOCREDE
		echo -e "\nComando utilizado: netstat -rn $(netstat -rn)\n " >> $DOCREDE
		
		echo -e "--- INFORMACOES DA TABELA DE ROTEAMETO --- \n" >> $DOCREDE
		echo -e "\nComando utilizado: cat /etc/iproute2/rt_tables\n\n$(cat /etc/iproute2/rt_tables)" >> $DOCREDE
		
		echo -e "\n--- INFORMACAO DE FIREWALL/IPTABLES ---\n " >> $DOCREDE	
		echo -e "\nComando utilizado: iptables -L\n\n $(iptables -L)" >> $DOCREDE
		###########################################################################
		echo -e "\n Contains TCP/UDP port numbers to service names mapping\n" > $DOCPORTSERVICE
		echo -e "\nComando usado: cat /etc/services\n $(cat /etc/services)\n" >> $DOCPORTSERVICE
		echo -e "\n Contains IP protocol numbers to protocol names mapping \n " >> $DOCPORTSERVICE
		echo -e "\nComando usado: cat /etc/protocols\n $(cat /etc/protocols)\n" >> $DOCPORTSERVICE
		###########################################################################
		echo -e "--- INFORMACOES DA CONFIGURACOES DE BUSCAS DE NOME" >> $DOCREDE
		echo -e "\nComando utilizado: cat /etc/nsswitch.conf\n\n$(cat /etc/nsswitch.conf)\n " >> $DOCREDE
		
		echo -e "---INFORMACOES DOS USUARIOS --- \n" >> $DOCREDE
		echo -e "\nComando utilizado: cat /etc/passwd\n\n$(cat /etc/passwd)\n" >> $DOCREDE

	elif [ $SO = $SUN ] ; then
		echo -e "IP configuration\nComando utilizado: cat /etc/ipadm/ipadm.conf \n$(cat /etc/ipadm/ipadm.conf)\n" >> $DOCREDE
		echo -e "Data-link configuration\nComando utilizado: cat /etc/dlamd/datalink.conf \n$(cat /etc/dladm/datalink.conf)\n" >> $DOCREDE
		echo -e "Network profiles\nComando utilizado: cat /etc/nwam/npc.conf \n$(cat /etc/nwam/npc.conf)\n" >> $DOCREDE
		
		echo -e "--- INFORMACOES DE DNS ---\n " >> $DOCREDE
		echo -e "\nComando utilizado: cat /etc/resolv.conf\n\n$(cat /etc/resolv.conf)\n" >> $DOCREDE
		
		echo -e "--- INFORMACOES DE NOME E DOMINIO DA MAQUINA---\n" >> $DOCREDE
		echo -e "\nComando utilizado: cat /etc/inet/hosts\n\n $(cat /etc/inet/hosts)\n" >> $DOCREDE
		
		echo -e "\n -- IFORMACOES DE ROTAS --- " >> $DOCREDE
		echo -e "\nComando utilizado: netstat -i $(netstat -i)\n " >> $DOCREDE
		
		echo -e "--- INFORMACOES DA TABELA DE ROTEAMETO --- \n" >> $DOCREDE
		echo -e "\nComando utilizado: netstat -r \n\n$(netstat -r)" >> $DOCREDE
		
		echo -e "\n--- INFORMACAO DE FIREWALL/IPTABLES ---\n " >> $DOCREDE	
		echo -e "\nComando utilizado: cat /etc/ipf/ipf.conf\n\n $(cat /etc/ipf/ipf.conf)" >> $DOCREDE
		
		###########################################################################
		echo -e "\n Contains TCP/UDP port numbers to service names mapping\n" > $DOCPORTSERVICE
		echo -e "\nComando usado: cat /etc/services\n $(cat /etc/services)\n" >> $DOCPORTSERVICE
		echo -e "\n Contains IP protocol numbers to protocol names mapping \n " >> $DOCPORTSERVICE
		echo -e "\nComando usado: cat /etc/protocols\n $(cat /etc/protocols)\n" >> $DOCPORTSERVICE
		###########################################################################
		echo -e "--- INFORMACOES DA CONFIGURACOES DE BUSCAS DE NOME" >> $DOCREDE
		echo -e "\nComando utilizado: cat /etc/nsswitch.conf\n\n$(cat /etc/nsswitch.conf)\n " >> $DOCREDE
		
		echo -e "---INFORMACOES DOS USUARIOS --- \n" >> $DOCREDE
		echo -e "\nComando utilizado: cat /etc/passwd\n\n$(cat /etc/passwd)\n" >> $DOCREDE
	fi
}
checkNETWORK

# checkQIP
# @date	    - 20/03/2018
# @author	- Ailson Ramon
# @version	- 1.0 (20/03/2018)
#	 Versao inicial
# @description
#	Pega as informacoes do Sofrware Vital QIP dependendo do SO
# @params
#	 void
# @return
#	 Void
function checkQIP
{
	local dir="/qip/"
	local qipdir="/opt/qip"
	if [ -d "$dir" ] ; then
		if [ $SO = $LINUX ] ; then
			echo -e "Informacoes do vercheck do QIP do Servidor $(uname -s)" > $DOCQIP
			/qip/cli/vercheck  >> $DOCQIP
			echo "Copiando os arquivos do qip.pcy para $(pwd)"
			cp /qip/qip.pcy $(pwd)/qip.pcy
			cp /qip/web/conf/qip.properties $(pwd)/qip.properties
			cp /qip/conf/hibernate.properties $(pwd)/hibernate.properties
			cp /qip/web/conf/ApplicationContext.xml $(pwd)/ApplicationContext.xml
			cp /qip/ldapauth.pcy $(pwd)/ldapauth.pcy
			
			
		elif [ $SO = $SUN ] ; then 
			echo -e "Informacoes do vercheck do QIP do Servidor $(uname -s)" > $DOCQIP
			/qip/cli/vercheck >> $DOCQIP
			echo "Copiando os arquivos do qip.pcy para $(pwd)"
			cp /qip/qip.pcy $(pwd)/qip.pcy
			cp /qip/web/conf/qip.properties $(pwd)/qip.properties
			cp /qip/conf/hibernate.properties $(pwd)/hibernate.properties
			cp /qip/web/conf/ApplicationContext.xml $(pwd)/ApplicationContext.xml
			cp /qip/ldapauth.pcy $(pwd)/ldapauth.pcy

		fi
	elif [ -d "$qipdir" ] ; then
		if [ $SO = $LINUX ] ; then
			echo -e "Informacoes do vercheck do QIP do Servidor $(uname -s)" > $DOCQIP
			/opt/qip/cli/vercheck >> $DOCQIP
			echo "Copiando os arquivos do qip.pcy para $(pwd)"
			cp /opt/qip/qip.pcy $(pwd)/qip.pcy
			cp /opt/qip/web/conf/qip.properties $(pwd)/qip.properties
			cp /opt/qip/conf/hibernate.properties $(pwd)/hibernate.properties
			cp /opt/qip/web/conf/ApplicationContext.xml $(pwd)/ApplicationContext.xml
			cp /opt/qip/ldapauth.pcy $(pwd)/ldapauth.pcy
		elif [ $SO = $SUN ] ; then 
			echo -e "Informacoes do vercheck do QIP do Servidor $(uname -s)" > DOCQIP
			/opt/qip/cli/vercheck >> $DOCQIP
			echo "Copiando os arquivos do qip.pcy para $(pwd)"
			cp /opt/qip/qip.pcy $(pwd)/qip.pcy
			cp /opt/qip/web/conf/qip.properties $(pwd)/qip.properties
			cp /opt/qip/conf/hibernate.properties $(pwd)/hibernate.properties
			cp /opt/qip/web/conf/ApplicationContext.xml $(pwd)/ApplicationContext.xml
			cp /opt/qip/ldapauth.pcy $(pwd)/ldapauth.pcy
		fi
	else
		echo "Diretorios $dir e $qipdir nao encontrados"
		
	fi

}
checkQIP
















