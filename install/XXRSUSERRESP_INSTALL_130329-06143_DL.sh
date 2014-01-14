#!/bin/bash
#************************************************************************************************************+
#--File Name          :       XXRSUSERRESP_INSTALL_130329-06143_DL.sh                                 | 
#--Program Purpose    :       Installation script for Rackspace User Responsibility Report.                   |
#--Author Name        :       Mahesh Guddeti                                                                  |
#--Initial Build Date :       17-JUN-2013                                                                    |
#							                                                     |
#--Version            :       1.0.0                                                                          |
#--Modification History                                                                                      |
#   | Ver   | Ticket No.   | Author          | Date        | Description                                     |
#------------------------------------------------------------------------------------------------------------+
#-- | 1.0.0 | 130329-06143 | Mahesh Guddeti   | 17-JUN-2013 | Initial Creation                                |
#------------------------------------------------------------------------------------------------------------+
#************************************************************************************************************/
#/* $Header: XXRSUSERRESP_INSTALL_130329-06143_DL.sh 1.0.0 17-JUN-2013 17:00:00 PM Mahesh Guddeti $ */
#--------------------------------------------------------------------------
# Set the environmental variables and other administrative requirements.
#--------------------------------------------------------------------------
 DATETIMESTAMP=`date +%Y%m%d%H%M%S`
 p_apps_usrn_pwd=$1
 jdbc=$2
 CUSTOM_TOP=$XXRS_TOP
 SQL_DIR=$CUSTOM_TOP/install/sql
 LDT_DIR=$CUSTOM_TOP/install/ldt
 XML_DIR=$CUSTOM_TOP/xml
 LOG_DIR=$CUSTOM_TOP/log
 INSTALL_DIR=$CUSTOM_TOP/install
 OUTDIR=$CUSTOM_TOP/out
 OUTFILE=$OUTDIR/XXRSUSRRESPAUDITSET_INSTALL_111122-02448_DL.out
 apps_login=apps
 
 echo `date` > $OUTFILE

#--------------------------------------------------------------------------
# Define the function to get the APPS and XXRS password.
#--------------------------------------------------------------------------
Psswd()
{
  if [ -n "$p_apps_usrn_pwd" ];then
    apps_pwd=${p_apps_usrn_pwd##*/}
  else
    echo "Please enter apps password =>"
    stty -echo
    read apps_pwd
    p_apps_usrn_pwd=apps/$apps_pwd
    stty echo
  fi
  if [ -n "$jdbc" ];then
    echo ""
  else
    echo "Please enter JDBC TNSNAMES Connection, (hostname:port:SID, dfw1svdevdbs02.ora.rackspace.com:1551:DEV)=>"
    read jdbc
  fi
}
#--------------------------------------------------------------------------
# Mailing output file
#--------------------------------------------------------------------------
MailOutFile()
{
  /bin/mail vaibhav.goyal@rackspace.com -c bruce.martinez@rackspace.com,tim.cowen@rackspace.com -s "Installation log for Downloading components for Rackspace User Responsibility Report in ${TWO_TASK}" < $OUTFILE
}
#--------------------------------------------------------------------------
# Using the FNDLOAD to Download AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

   FNDLOAD ${p_apps_usrn_pwd} 0 Y DOWNLOAD $FND_TOP/patch/115/import/afcpprog.lct XXRSUSERRESP.ldt PROGRAM APPLICATION_SHORT_NAME="XXRS" CONCURRENT_PROGRAM_NAME="XXRSUSERRESP" >> $OUTFILE
   FNDLOAD ${p_apps_usrn_pwd} 0 Y DOWNLOAD $XDO_TOP/patch/115/import/xdotmpl.lct XXRSUSERRESP_XML.ldt XDO_DS_DEFINITIONS APPLICATION_SHORT_NAME="XXRS" DATA_SOURCE_CODE="XXRSUSERRESP" >> $OUTFILE

   FNDLOAD ${p_apps_usrn_pwd} 0 Y DOWNLOAD $FND_TOP/patch/115/import/afcpprog.lct XXRSUSERRESPPUT.ldt PROGRAM APPLICATION_SHORT_NAME="XXRS" CONCURRENT_PROGRAM_NAME="XXRSUSERRESPPUT" >> $OUTFILE

   FNDLOAD ${p_apps_usrn_pwd} 0 Y DOWNLOAD $FND_TOP/patch/115/import/afcprset.lct XXRSUSERRESP_SET.ldt REQ_SET APPLICATION_SHORT_NAME="XXRS" REQUEST_SET_NAME="XXRSUSERRESP_SET"
   FNDLOAD ${p_apps_usrn_pwd} 0 Y DOWNLOAD $FND_TOP/patch/115/import/afcprset.lct XXRSUSERRESP_SET_LNK.ldt REQ_SET_LINKS REQUEST_SET_NAME="XXRSUSERRESP_SET"

   FNDLOAD ${p_apps_usrn_pwd} 0 Y DOWNLOAD $FND_TOP/patch/115/import/afcprset.lct XXRSUSERRESP_SET.ldt REQ_SET_LINKS REQUEST_SET_NAME="XXRSUSERRESP_SET"

   FNDLOAD ${p_apps_usrn_pwd} 0 Y DOWNLOAD $FND_TOP/patch/115/import/afcpreqg.lct XXRSUSERRESP_SET_RG.ldt REQUEST_GROUP REQUEST_GROUP_NAME='System Administrator Reports' APPLICATION_SHORT_NAME='SYSADMIN' UNIT_TYPE='S' UNIT_APP='XXRS' UNIT_NAME='XXRSUSERRESP_SET'

  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}

Psswd

echo -e "\nLOADING AOL Data...\n" >> $OUTFILE
LoadAOLData

echo -e "\nDone.\n" >> $OUTFILE

echo -e "\nEmailing the outfile.\n"
MailOutFile

echo -e "\nOutput file is ${OUTFILE}"
