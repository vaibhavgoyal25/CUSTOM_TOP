#!/bin/bash

#/**************************************************************************************************
#* NAME : XXRS_FND_RS_USERRESP.sh                                                                  *
#* DESCRIPTION :                                                                                   *
#*  Script to assign responsibility for fst team                                                   *
#*                                                                                                 *
#* AUTHOR       : Pavan Amirineni                                                                  *
#* DATE WRITTEN : 14-JUN-2012                                                                      *
#*                                                                                                 *
#* CHANGE CONTROL :                                                                                *
#* Version# | Ticket #     |  WHO            | DATE       |   REMARKS                              *
#*-------------------------------------------------------------------------------------------------*
#* 1.0.0    | N/A for PROD | Pavan Amirineni | 14-JUN-2012 | Initial Creation                      *
#**************************************************************************************************/
#
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
 OUTFILE=$OUTDIR/XXRS_FND_RS_USERRESP.out
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
}

#--------------------------------------------------------------------------
# Using the FNDLOAD to load AOL objects
#--------------------------------------------------------------------------
LoadAOLData()
{
  cd ${LDT_DIR}

  FNDLOAD $p_apps_usrn_pwd O Y UPLOAD @FND:patch/115/import/afsload.lct  RS_USER_MAINTENANCE_MENU.ldt >> $OUTFILE

  FNDLOAD $p_apps_usrn_pwd 0 Y UPLOAD @FND:patch/115/import/afscursp.lct RS_USER_MAINTENANCE_RESP.ldt >> $OUTFILE

  cat *.log >> $OUTFILE
  mv *.log ${LOG_DIR}
}
assignresp()
{
  cd $SQL_DIR
sqlplus $p_apps_usrn_pwd << EOF
spool $OUTFILE
@XXRS_FND_RESP_ASSIGN_SCRIPT.sql
EOF
}
#--------------------------------------------------------------------------
# Calling Functions
#--------------------------------------------------------------------------

Psswd
echo -e "\nLOADING AOL Data...\n" >> $OUTFILE
LoadAOLData
echo -e "\nAssigning Responsibilities...\n" >> $OUTFILE
assignresp
echo -e "\nOutput file is ${OUTFILE}"
